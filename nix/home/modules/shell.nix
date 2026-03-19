{ ... }:

let
  replacements = {
    adb = "adb -a";
    c = "clear";
    dot = "cd ~/.dotfiles";
    l = "eza";
    la = "eza -la --git --icons --group-directories-first";
    ll = "eza -ll --git --icons --group-directories-first";
    yeet = "rm -rf";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    a = "z";
  };

  devCommands = {
    gs = "git status";
    ga = "git add";
    gl = "git log --oneline";
    gds = "git diff --staged";
    push = "git push";
    pull = "git pull";
    py = "python";
    cr = "cargo run";
    cb = "cargo build";
    ct = "cargo test";
    yd = "yarn dev";
    ys = "yarn start";
    yb = "yarn build";
    pn = "pnpm";
    pd = "pnpm dev";
    pb = "pnpm build";
    t = "tmux";
    ta = "tmux a";
    lg = "lazygit";
    stk = "stklos -l ~/dev/sicp/simply.scm";
    aout = "./a.out";
    gmc = "geminicommit";
  };

  workspaceShortcuts = {
    vestaconfig = "vim /mnt/config/vesta/vesta.toml";
    caddyconfig = "vim /mnt/sshfs/eir/root/apps/caddy/Caddyfile";
    todo = "vim ~/personal/notes/todo.md";
  };

  containers = {
    dlog = "docker compose logs -f";
    dbuild = "docker compose up --build";
  };

  utilities = {
    speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";
    "active-ports" = "sudo lsof -i -P -n | grep LISTEN";
    "mkdir-date" = "mkdir $(date +'%Y-%m-%d')";
  };

  systemMaintenance = {
    "update-grub" = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
    "ua-drop-caches" = "sudo paccache -rk3; paru -Sc --aur --noconfirm";
    "ua-update-all" =
      "export TMPFILE=\"$(mktemp)\"; sudo true; rate-mirrors --save=$TMPFILE arch --max-delay=21600 && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup && sudo mv $TMPFILE /etc/pacman.d/mirrorlist && ua-drop-caches && paru -Syyu --noconfirm";
  };

  nixos = {
    rb = "sudo nixos-rebuild switch";
    nixpkgs = "web-search nixpkgs";
    nixoptions = "web-search nixoptions";
  };
in
{
  home.shellAliases =
    replacements
    // devCommands
    // workspaceShortcuts
    // containers
    // utilities
    // systemMaintenance
    // nixos;
}
