{ ... }:

let
  switchToWorkspace = number: key: {
    name = "switch-to-workspace-${toString number}";
    value = [ key ];
  };
  moveToWorkspace = number: key: {
    name = "move-to-workspace-${toString number}";
    value = [ "<Super><Shift>${key}" ];
  };
  workspaceKeys = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ];
in
{
  dconf.settings = {
    "org/gnome/mutter".dynamic-workspaces = false;
    "org/gnome/desktop/wm/preferences".num-workspaces = 8;

    "org/gnome/desktop/wm/keybindings" = builtins.listToAttrs (
      builtins.concatLists (builtins.genList (index: [
        (switchToWorkspace (index + 1) "<Super>${builtins.elemAt workspaceKeys index}")
        (moveToWorkspace (index + 1) (builtins.elemAt workspaceKeys index))
      ]) 10)
    );
  };
}
