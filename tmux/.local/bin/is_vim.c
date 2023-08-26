#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// https://github.com/Collin-T/is_vim

// structs

// use stringref to avoid redundant allocations
typedef struct __stringref {
  const char *str;
  size_t len;
} stringref;

// a process info struct to contain data
typedef struct __process_info {
  unsigned pid, ppid;
  stringref name, state, tty;
} process_info;

// the size of each chunk that is digested
// at the moment this is 4KB
#define PROCESS_INFO_DIGEST_SIZE (1 << 12)

#define ZONE_UNINITIALIZED 0
#define ZONE_PID 1
#define ZONE_PID_DELIMITER 2
#define ZONE_PPID 3
#define ZONE_PPID_DELIMITER 4
#define ZONE_STATE 5
#define ZONE_STATE_DELIMITER 6
#define ZONE_TTY 7
#define ZONE_TTY_DELIMITER 8
#define ZONE_NAME 9

char *raw_process_info = NULL;
size_t raw_process_info_size = 0;

process_info *processes = NULL;
size_t process_count = 0, process_capacity = 0;

int is_line_separator(char c) { return c == '\n' || c == '\0'; }

int is_delimiter(char c) {
  return c == ' ' || c == '\t' || is_line_separator(c);
}

int status_is_active(const stringref *status) {
  int code = status->str[0];
  return code != 'T' && code != 'X' && code != 'Z';
}

unsigned parse_pid(const stringref *ref) {
  unsigned output = 0;
  for (size_t i = 0; i < ref->len; i++) {
    output *= 10;
    output += ref->str[i] - '0';
  }

  return output;
}

void trim(stringref *ref) {
  const char *start = ref->str, *end = &ref->str[ref->len - 1];

  while (is_delimiter(*start))
    start++;

  while (is_delimiter(*end))
    end--;

  ref->str = start;
  ref->len = end - start + 1;
}

int stringref_equal(const stringref *str1, const stringref *str2) {
  if (str1->len != str2->len)
    return 0;

  return memcmp(str1->str, str2->str, str1->len) == 0;
}

int get_ps_output() {
  FILE *stream = popen("ps ax -o pid=,ppid=,state=,tty=,comm=", "r");
  size_t digest_count;
  if (!stream)
    return EXIT_FAILURE;

  do {
    raw_process_info = realloc(raw_process_info, raw_process_info_size +
                                                     PROCESS_INFO_DIGEST_SIZE);
    if (!raw_process_info)
      return ENOMEM;

    digest_count = fread(&raw_process_info[raw_process_info_size], 1,
                         PROCESS_INFO_DIGEST_SIZE, stream);
    raw_process_info_size += digest_count;
  } while (digest_count == PROCESS_INFO_DIGEST_SIZE);

  fclose(stream);

  return 0;
}

void get_item_offsets(size_t *pid_end, size_t *ppid_end, size_t *state_start,
                      size_t *tty_start, size_t *name_start) {
  size_t offset = 0;

  for (int zone = ZONE_UNINITIALIZED; zone != ZONE_NAME; offset++) {
    int delimiter = is_delimiter(raw_process_info[offset]);

    if (!delimiter && !(zone & 1)) {
      // even states are delimiters
      // and so the state changes when a non-delimiter is reached

      if (zone == ZONE_PPID_DELIMITER)
        *state_start = offset;
      else if (zone == ZONE_STATE_DELIMITER)
        *tty_start = offset;
      else if (zone == ZONE_TTY_DELIMITER)
        *name_start = offset;
      zone++;

    } else if (delimiter && (zone & 1)) {
      // odd states are not delimiters
      // and so the state changes when a delimiter is reached

      if (zone == ZONE_PID)
        *pid_end = offset;
      else if (zone == ZONE_PPID)
        *ppid_end = offset;
      zone++;
    }
  }
}

int parse_process_output() {
  stringref item;

  size_t pid_end, ppid_end, state_start, tty_start, name_start;

  get_item_offsets(&pid_end, &ppid_end, &state_start, &tty_start, &name_start);

  for (size_t offset = 0; offset < raw_process_info_size; process_count++) {

    // resize if necessary
    if (process_count + 1 >= process_capacity) {
      process_capacity = (process_count + 1) * 2;

      processes = realloc(processes, sizeof(process_info) * process_capacity);
      if (!processes)
        return ENOMEM;
    }

    // parse pid
    item.str = &raw_process_info[offset];
    item.len = pid_end;
    trim(&item);
    processes[process_count].pid = parse_pid(&item);

    // parse ppid
    item.str = &raw_process_info[offset + pid_end];
    item.len = ppid_end - pid_end;
    trim(&item);
    processes[process_count].ppid = parse_pid(&item);

    // parse state
    item.str = &raw_process_info[offset + state_start];
    item.len = tty_start - state_start;
    trim(&item);
    memcpy(&processes[process_count].state, &item, sizeof(item));

    // parse tty
    item.str = &raw_process_info[offset + tty_start];
    item.len = name_start - tty_start;
    trim(&item);
    memcpy(&processes[process_count].tty, &item, sizeof(item));

    // parse name
    // since name goes to the end of the line, we must find the length manually
    offset += name_start;
    item.str = &raw_process_info[offset];

    item.len = 0;
    while (!is_line_separator(raw_process_info[offset++]))
      item.len++;

    trim(&item);
    memcpy(&processes[process_count].name, &item, sizeof(item));
  }

  return 0;
}

int find_vim(const char *tty) {
  size_t *procs = malloc(sizeof(size_t) * process_count),
         *pprocs = malloc(sizeof(size_t) * process_count);
  size_t proc_count = 0, pproc_count = 0;

  // wrap strings in stringrefs for faster/easier comparing
  stringref tty_ref, vim_ref, nvim_ref;

  tty_ref.str = tty;
  tty_ref.len = strlen(tty);

  vim_ref.str = "vim";
  vim_ref.len = strlen(vim_ref.str);

  nvim_ref.str = "nvim";
  nvim_ref.len = strlen(nvim_ref.str);

  // find initial pids (which must belong to the current tty)
  for (size_t i = 0; i < process_count; i++) {
    if (stringref_equal(&tty_ref, &processes[i].tty)) {
      procs[proc_count++] = i;
    }
  }

  while (proc_count > 0) {
    for (size_t i = 0; i < proc_count; i++) {
      if ((stringref_equal(&processes[procs[i]].name, &vim_ref) ||
           stringref_equal(&processes[procs[i]].name, &nvim_ref)) &&
          status_is_active(&processes[procs[i]].state)) {

        free(procs);
        free(pprocs);
        return 0;
      }
    }

    // find child processes
    // pprocs and procs are swapped to avoid redundant mallocs
    size_t *tmp = procs;
    procs = pprocs;
    pprocs = tmp;

    pproc_count = proc_count;
    proc_count = 0;

    for (size_t i = 0; i < pproc_count; i++)
      for (size_t j = 0; j < process_count; j++)
        if (processes[pprocs[i]].pid == processes[j].ppid)
          procs[proc_count++] = j;
  }

  free(procs);
  free(pprocs);
  return EXIT_FAILURE;
}

void cleanup() {
  if (processes != NULL) {
    free(processes);
    processes = NULL;
  }
  if (raw_process_info != NULL) {
    free(raw_process_info);
    raw_process_info = NULL;
  }
}

int main(int argc, char **argv) {
  if (argc != 2) {
    fputs("No tty given!\n", stderr);
    return 1;
  }

  atexit(cleanup);

  if (get_ps_output() != 0) {
    cleanup();
    return EXIT_FAILURE;
  }

  if (parse_process_output() != 0) {
    cleanup();
    return EXIT_FAILURE;
  }

  int exit_code;
  if (strncmp(argv[1], "/dev/", 5) == 0)
    exit_code = find_vim(&argv[1][5]);
  else
    exit_code = find_vim(argv[1]);

  cleanup();
  return exit_code;
}
