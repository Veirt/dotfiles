{ pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [
    delta
    hunk
  ];

  programs.git = {
    enable = true;
    settings = {
      core.pager = "${pkgsUnstable.delta}/bin/delta";
      interactive.diffFilter = "${pkgsUnstable.delta}/bin/delta --color-only";
      delta = {
        navigate = true;
        side-by-side = true;
      };
      fetch.prune = true;
      merge.conflictStyle = "zdiff3";
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
  };
}
