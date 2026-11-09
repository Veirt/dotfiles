#define _GNU_SOURCE

#include <ctype.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <unistd.h>

#define COMM_SIZE 16
#define STAT_BUFFER_SIZE 1024

typedef struct {
  int pid;
  int ppid;
  unsigned tty_major;
  unsigned tty_minor;
  char state;
  char comm[COMM_SIZE];
} process_info;

typedef struct {
  process_info *items;
  size_t count;
  size_t capacity;
} process_list;

typedef struct {
  int *items;
  size_t count;
  size_t capacity;
} pid_list;

static int is_inactive_state(char state) {
  return state == 'T' || state == 'X' || state == 'x' || state == 'Z';
}

static int ends_with(const char *str, size_t *len, const char *suffix) {
  size_t suffix_len = strlen(suffix);

  if (*len < suffix_len)
    return 0;

  if (memcmp(str + *len - suffix_len, suffix, suffix_len) != 0)
    return 0;

  *len -= suffix_len;
  return 1;
}

static int is_vim_name(const char *str, size_t len) {
  size_t i = 0;

  if (i < len && str[i] == 'l')
    i++;
  if (i < len && str[i] == 'n')
    i++;

  if (i + 2 > len || str[i] != 'v' || str[i + 1] != 'i')
    return 0;
  i += 2;

  if (i < len && str[i] == 'm')
    i++;
  if (i < len && str[i] == 'x')
    i++;

  return i == len;
}

static int is_editor(const char *comm) {
  size_t len = strlen(comm);

  if (len == 0)
    return 0;

  if (*comm == 'g') {
    comm++;
    len--;
  }

  if (len > 0 && *comm == '.') {
    comm++;
    len--;
  }

  ends_with(comm, &len, "-wrapped");
  ends_with(comm, &len, "diff");

  if (len == 3 && memcmp(comm, "fzf", len) == 0)
    return 1;

  if (len == 4 && memcmp(comm, "view", len) == 0)
    return 1;

  return is_vim_name(comm, len);
}

static int parse_pid_name(const char *name, int *pid) {
  char *end = NULL;
  long value;

  if (!isdigit((unsigned char)name[0]))
    return 0;

  errno = 0;
  value = strtol(name, &end, 10);
  if (errno != 0 || *end != '\0' || value <= 0 || value > 0x7fffffff)
    return 0;

  *pid = (int)value;
  return 1;
}

static int parse_pid_arg(const char *arg, int *pid) {
  char *end = NULL;
  long value;

  errno = 0;
  value = strtol(arg, &end, 10);
  if (errno != 0 || *end != '\0' || value <= 0 || value > 0x7fffffff)
    return 0;

  *pid = (int)value;
  return 1;
}

static unsigned proc_tty_major(int tty_nr) {
  return ((unsigned)tty_nr >> 8) & 0xfff;
}

static unsigned proc_tty_minor(int tty_nr) {
  unsigned value = (unsigned)tty_nr;
  return (value & 0xff) | ((value >> 12) & 0xfff00);
}

static int next_long(const char **input, long *value) {
  char *end = NULL;

  while (**input == ' ')
    (*input)++;

  if (**input == '\0')
    return 0;

  errno = 0;
  *value = strtol(*input, &end, 10);
  if (errno != 0 || end == *input)
    return 0;

  *input = end;
  return 1;
}

static int parse_stat_line(const char *line, process_info *process) {
  const char *left = strchr(line, '(');
  const char *right = strrchr(line, ')');
  const char *cursor;
  char *end = NULL;
  long pid, ppid, skipped, tty_nr;
  size_t comm_len;

  if (left == NULL || right == NULL || right <= left)
    return 0;

  errno = 0;
  pid = strtol(line, &end, 10);
  if (errno != 0 || end != left - 1 || pid <= 0 || pid > 0x7fffffff)
    return 0;

  comm_len = (size_t)(right - left - 1);
  if (comm_len >= COMM_SIZE)
    comm_len = COMM_SIZE - 1;

  memset(process, 0, sizeof(*process));
  process->pid = (int)pid;
  memcpy(process->comm, left + 1, comm_len);
  process->comm[comm_len] = '\0';

  cursor = right + 1;
  while (*cursor == ' ')
    cursor++;
  if (*cursor == '\0')
    return 0;

  process->state = *cursor++;

  if (!next_long(&cursor, &ppid))
    return 0;
  process->ppid = (int)ppid;

  if (!next_long(&cursor, &skipped))
    return 0;
  if (!next_long(&cursor, &skipped))
    return 0;
  if (!next_long(&cursor, &tty_nr))
    return 0;

  if (tty_nr != 0) {
    process->tty_major = proc_tty_major((int)tty_nr);
    process->tty_minor = proc_tty_minor((int)tty_nr);
  }

  return 1;
}

static int read_process_stat(int pid, process_info *process) {
  char path[64];
  char buffer[STAT_BUFFER_SIZE];
  ssize_t count;
  int fd;

  if (snprintf(path, sizeof(path), "/proc/%d/stat", pid) >= (int)sizeof(path))
    return 0;

  fd = open(path, O_RDONLY | O_CLOEXEC);
  if (fd < 0)
    return 0;

  count = read(fd, buffer, sizeof(buffer) - 1);
  close(fd);

  if (count <= 0)
    return 0;

  buffer[count] = '\0';
  return parse_stat_line(buffer, process);
}

static int pid_list_push(pid_list *list, int pid) {
  int *items;
  size_t capacity;

  if (list->count == list->capacity) {
    capacity = list->capacity == 0 ? 16 : list->capacity * 2;
    items = realloc(list->items, capacity * sizeof(list->items[0]));
    if (items == NULL)
      return 0;

    list->items = items;
    list->capacity = capacity;
  }

  list->items[list->count++] = pid;
  return 1;
}

static int read_child_pids(int pid, pid_list *children) {
  char path[96];
  char buffer[4096];
  const char *cursor = buffer;
  ssize_t count;
  int fd;

  if (snprintf(path, sizeof(path), "/proc/%d/task/%d/children", pid, pid) >=
      (int)sizeof(path))
    return 1;

  fd = open(path, O_RDONLY | O_CLOEXEC);
  if (fd < 0)
    return 1;

  count = read(fd, buffer, sizeof(buffer) - 1);
  close(fd);
  if (count <= 0)
    return 1;

  buffer[count] = '\0';

  while (*cursor != '\0') {
    long child_pid;

    while (*cursor == ' ' || *cursor == '\n')
      cursor++;

    if (*cursor == '\0')
      break;

    if (!next_long(&cursor, &child_pid))
      return 1;

    if (child_pid > 0 && child_pid <= 0x7fffffff &&
        !pid_list_push(children, (int)child_pid))
      return 0;
  }

  return 1;
}

static int process_list_push(process_list *list, const process_info *process) {
  process_info *items;
  size_t capacity;

  if (list->count == list->capacity) {
    capacity = list->capacity == 0 ? 128 : list->capacity * 2;
    items = realloc(list->items, capacity * sizeof(list->items[0]));
    if (items == NULL)
      return 0;

    list->items = items;
    list->capacity = capacity;
  }

  list->items[list->count++] = *process;
  return 1;
}

static int read_processes(process_list *list) {
  DIR *proc = opendir("/proc");
  struct dirent *entry;

  if (proc == NULL)
    return 0;

  while ((entry = readdir(proc)) != NULL) {
    process_info process;
    int pid;

    if (!parse_pid_name(entry->d_name, &pid))
      continue;

    if (read_process_stat(pid, &process) && !process_list_push(list, &process)) {
      closedir(proc);
      return 0;
    }
  }

  closedir(proc);
  return 1;
}

static int get_target_tty(const char *arg, unsigned *target_major,
                          unsigned *target_minor) {
  char path[256];
  const char *tty_path = arg;
  struct stat st;

  if (strncmp(arg, "/dev/", 5) != 0) {
    if (snprintf(path, sizeof(path), "/dev/%s", arg) >= (int)sizeof(path))
      return 0;
    tty_path = path;
  }

  if (stat(tty_path, &st) != 0 || !S_ISCHR(st.st_mode))
    return 0;

  *target_major = major(st.st_rdev);
  *target_minor = minor(st.st_rdev);
  return 1;
}

static int process_has_tty(const process_info *process, unsigned tty_major,
                           unsigned tty_minor) {
  return process->tty_major == tty_major && process->tty_minor == tty_minor;
}

static int find_vim(const process_list *list, unsigned tty_major,
                    unsigned tty_minor) {
  size_t *frontier = NULL;
  size_t *next = NULL;
  size_t frontier_count = 0;
  int found = 0;

  if (list->count == 0)
    return 0;

  frontier = malloc(list->count * sizeof(frontier[0]));
  next = malloc(list->count * sizeof(next[0]));
  if (frontier == NULL || next == NULL)
    goto done;

  for (size_t i = 0; i < list->count; i++) {
    if (process_has_tty(&list->items[i], tty_major, tty_minor))
      frontier[frontier_count++] = i;
  }

  while (frontier_count > 0) {
    size_t next_count = 0;

    for (size_t i = 0; i < frontier_count; i++) {
      const process_info *process = &list->items[frontier[i]];

      if (!is_inactive_state(process->state) && is_editor(process->comm)) {
        found = 1;
        goto done;
      }
    }

    for (size_t i = 0; i < frontier_count; i++) {
      int parent_pid = list->items[frontier[i]].pid;

      for (size_t j = 0; j < list->count; j++) {
        if (list->items[j].ppid == parent_pid)
          next[next_count++] = j;
      }
    }

    {
      size_t *tmp = frontier;
      frontier = next;
      next = tmp;
      frontier_count = next_count;
    }
  }

done:
  free(frontier);
  free(next);
  return found;
}

static int find_vim_from_root(int root_pid, unsigned tty_major,
                              unsigned tty_minor) {
  pid_list frontier = {0};
  int found = 0;

  if (!pid_list_push(&frontier, root_pid))
    goto done;

  for (size_t i = 0; i < frontier.count; i++) {
    process_info process;

    if (!read_process_stat(frontier.items[i], &process))
      continue;

    if (i == 0 && !process_has_tty(&process, tty_major, tty_minor))
      continue;

    if (!is_inactive_state(process.state) && is_editor(process.comm)) {
      found = 1;
      goto done;
    }

    if (!read_child_pids(process.pid, &frontier))
      goto done;
  }

done:
  free(frontier.items);
  return found;
}

int main(int argc, char **argv) {
  process_list processes = {0};
  unsigned tty_major = 0, tty_minor = 0;
  int root_pid = 0;
  int found;

  if (argc != 2 && argc != 3) {
    fputs("No tty given!\n", stderr);
    return EXIT_FAILURE;
  }

  if (!get_target_tty(argv[1], &tty_major, &tty_minor))
    return EXIT_FAILURE;

  if (argc == 3 && parse_pid_arg(argv[2], &root_pid))
    return find_vim_from_root(root_pid, tty_major, tty_minor) ? EXIT_SUCCESS
                                                              : EXIT_FAILURE;

  if (!read_processes(&processes)) {
    free(processes.items);
    return EXIT_FAILURE;
  }

  found = find_vim(&processes, tty_major, tty_minor);
  free(processes.items);

  return found ? EXIT_SUCCESS : EXIT_FAILURE;
}
