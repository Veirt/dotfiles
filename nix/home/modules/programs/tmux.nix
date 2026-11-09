{ ... }:

{
  xdg.configFile."tmux".source = ../../files/tmux/config;

  home.file = {
    ".local/bin/is_vim.c".source = ../../files/tmux/bin/is_vim.c;
    ".local/bin/tmux-sessionizer".source = ../../files/tmux/bin/tmux-sessionizer;
    ".local/bin/tmux-vim-select-pane".source = ../../files/tmux/bin/tmux-vim-select-pane;
  };
}
