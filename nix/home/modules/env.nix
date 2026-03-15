{ ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.local/share/bun/bin"
    "$HOME/.local/share/go/bin"
    "$HOME/.local/share/cargo/bin"
    "$HOME/.config/composer/vendor/bin"
    "$HOME/.local/share/nvim/mason/bin"
  ];
}
