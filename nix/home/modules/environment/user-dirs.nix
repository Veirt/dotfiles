{ ... }:

{
  config.xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "$HOME/";
    templates = "$HOME/personal/templates";
    videos = "$HOME/personal/videos";
    music = "$HOME/personal/music";
    download = "$HOME/downloads";
    publicShare = "$HOME/public";
    documents = "$HOME/documents";
    pictures = "$HOME/pictures";
  };
}
