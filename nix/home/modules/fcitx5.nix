{ lib, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-fluent
      ];

      settings = {
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateForwardKeys = "";
            EnumerateBackwardKeys = "";
            EnumerateSkipFirst = false;
            ActivateKeys = "";
            DeactivateKeys = "";
            ModifierOnlyKeyTimeout = 250;
          };

          "Hotkey/TriggerKeys"."0" = "Super+space";
          "Hotkey/AltTriggerKeys"."0" = "Shift_L";
          "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
          "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
          "Hotkey/PrevCandidate"."0" = "Shift+Tab";
          "Hotkey/NextCandidate"."0" = "Tab";
          "Hotkey/TogglePreedit"."0" = "Control+Alt+P";

          Behavior = {
            ActiveByDefault = false;
            resetStateWhenFocusIn = "No";
            ShareInputState = "No";
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            showInputMethodInformationWhenFocusIn = false;
            CompactInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOption = false;
            CustomXkbOption = "";
            EnabledAddons = "";
            DisabledAddons = "";
            PreloadInputMethod = true;
            AllowInputMethodForPassword = false;
            ShowPreeditForPassword = false;
            AutoSavePeriod = 30;
          };
        };

        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };

          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };

          "Groups/0/Items/1" = {
            Name = "mozc";
            Layout = "";
          };

          GroupOrder."0" = "Default";
        };

        addons = {
          classicui.globalSection = {
            "Vertical Candidate List" = false;
            WheelForPaging = true;
            Font = "Sans 10";
            MenuFont = "Sans 10";
            TrayFont = "Sans Bold 10";
            TrayOutlineColor = "#000000";
            TrayTextColor = "#ffffff";
            PreferTextIcon = false;
            ShowLayoutNameInIcon = true;
            UseInputMethodLanguageToDisplayText = true;
            Theme = "FluentDark";
            DarkTheme = "FluentDark";
            UseDarkTheme = false;
            UseAccentColor = true;
            PerScreenDPI = true;
            ForceWaylandDPI = 0;
            EnableFractionalScale = true;
          };

        };
      };
    };
  };

  home.sessionVariables = {
    QT_IM_MODULE = lib.mkForce "xim";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };
}
