# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  commonSshKey = "/home/veirt/.ssh/id_ed25519";
  commonSshfsOptions = [
    "defaults"
    "noatime"
    "allow_other"
    "reconnect"
    "delay_connect"
    "x-systemd.automount"
    "IdentityFile=${commonSshKey}"
    "_netdev"
    "StrictHostKeyChecking=no"
    "UserKnownHostsFile=/dev/null"
  ];
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.systemd-boot.enable = false;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # https://gist.github.com/jfeilbach/f06bb8408626383a083f68276fa4df8a
  boot.kernelParams = [
    "loglevel=1"
    "nowatchdog"
    "kernel.nmi_watchdog=0"
    "noibrs"
    "noibpb"
    "nopti"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "mds=off"
    "tsx=on"
    "tsx_async_abort=off"
    "mitigations=off"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      libGL
    ];
    setLdLibraryPath = true;
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
  hardware.cpu.amd.updateMicrocode = true;
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  hardware.bluetooth.enable = true;

  # Define your hostname.
  networking.hostName = "minerva";
  # networking.wireless.enable = true;
  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    wifi.macAddress = "random";
  };
  networking.wireless.iwd.settings = {
    General = {
      AddressRandomization = "network";
      AddressRandomizationRange = "full";
    };
    Settings = {
      AlwaysRandomizeAddress = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Makassar";
  time.hardwareClockInLocalTime = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    geary # email client
    seahorse # password manager
    # these should be self explanatory
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-screenshot
    gnome-weather
    pkgs.gnome-connections
    pkgs.gedit
  ];

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.veirt = {
    isNormalUser = true;
    description = "Veirt";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
      "docker"
      "adbusers"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      obsidian
      vesktop
      discord
      webcord
      arrpc
      mailspring
      betterbird
      mpv
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
          wlrobs
        ];
      })
      picard
    ];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
      fcitx5-mozc
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };


  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # must have
    unzip
    unrar
    wget
    killall
    rsync
    lzip # waydroid

    # utilities
    traceroute
    dig
    stow
    gotop
    bottom
    powertop
    aria2
    imagemagick
    ffmpeg
    nmap
    sshfs
    wireguard-tools
    gallery-dl
    file

    # dev tools
    git
    lazygit
    gnupg
    fzf
    zoxide
    ripgrep
    fd
    eza
    bat
    gcc
    gnumake
    just
    nodejs
    deno
    pnpm
    unstable.bun
    rustup
    pkg-config
    openssl
    docker-buildx
    cargo-watch
    cargo-bump
    go
    python3
    pipx
    mods # ai on cli
    php 
    php82Packages.composer
    git-repo # build waydroid
    jq
    wgo
    chromedriver
    zola # web dev
    terraform
    awscli2

    # android development
    # flutter
    # unstable.android-studio
    android-tools
    # jdk19
    vscode.fhs
    unstable.zed-editor

    google-chrome
    chromium
    tree-sitter # neovim
    luarocks # neovim
    lua

    cloudflare-warp
    pulseaudio
    pamixer
    mpd
    unstable.mpd-discord-rpc
    libjxl
    scrcpy # screen copy
    typst
    libreoffice-qt6-still
    v4l-utils

    # customization
    gnome.gnome-tweaks
    orchis-theme
    tela-icon-theme

    # thumbnailer
    ffmpegthumbnailer
    evince # pdf thumbnailer
    gnome.totem # audio thumbnailer

    # apps
    nur.repos.nltch.spotify-adblock
    bruno # api testing 
    postman # api testing
    beekeeper-studio # db admin tool
    remmina # rdp
    easyeffects
    pavucontrol
    gthumb

    # cli apps
    mpc-cli
    ncmpcpp
    fastfetch
    cmatrix
    asciiquarium
    pfetch
    ngrok

    # gaming
    winetricks
    wineWowPackages.waylandFull
    protonup
    lutris
    prismlauncher

    gnome-network-displays
    google-cloud-sdk
    gnome.ghex
    tesseract
    yt-dlp
    act
  ];
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.tumbler.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  virtualisation.docker.enable = true;
  systemd.services.docker.wantedBy = pkgs.lib.mkForce [ ];
  systemd.services."docker.socket".wantedBy = pkgs.lib.mkForce [ ];

  security.sudo.wheelNeedsPassword = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" ];
    serif = [ "Noto Serif" "Source Han Serif" ];
    sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

  environment.variables = {
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
    EDITOR = "nvim";
    VISUAL = "nvim";
    GTK_THEME = "Orchis-Grey-Dark-Compact";
    TERMINAL = "foot";
    BROWSER = "firefox";
    GUIFM = "nautilus";
    TUIFM = "yazi";
  };

  fileSystems = {
    "/mnt/windows" =
    { device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000" "x-systemd.automount" ];
    };

    "/mnt/storage" = {
      device = "192.168.1.200:/mnt/storage";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "x-systemd.automount" "noatime" "noauto" "_netdev" ];
    };
    "/mnt/sata-ssd" = {
      device = "192.168.1.200:/mnt/sata-ssd";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "x-systemd.automount" "noatime" "noauto" "_netdev" ];
    };

    "/mnt/sshfs/hera" = {
      device = "veirt@hera:/";
      fsType = "sshfs";
      options = commonSshfsOptions;
    };
    "/mnt/sshfs/freya" = {
      device = "veirt@freya:/";
      fsType = "sshfs";
      options = commonSshfsOptions;
    };
    "/mnt/sshfs/eir" = {
      device = "root@eir:/";
      fsType = "sshfs";
      options = commonSshfsOptions;
    };
    "/mnt/sshfs/elfriede" = {
      device = "root@elfriede:/";
      fsType = "sshfs";
      options = commonSshfsOptions;
    };
    "/mnt/sshfs/rhea" = {
      device = "root@rhea:/";
      fsType = "sshfs";
      options = commonSshfsOptions;
    };
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "foot";
  };
  programs.tmux.enable = true;
  programs.yazi.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    package = unstable.neovim-unwrapped;
  };
  # https://www.reddit.com/r/NixOS/comments/13uc87h/masonnvim_broke_on_nixos/
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [                                                                                                                                                                                            
    openssl                                                                                                                                                                                                                           
    xorg.libX11                                                                                                                                                                                                                       
    xorg.libXcursor                                                                                                                                                                                                                   
    xorg.libxcb                                                                                                                                                                                                                       
    xorg.libXi                                                                                                                                                                                                                        
    libxkbcommon                                                                                                                                                                                                                      
    libz                                                                                                                                                                                                                              
];

  # enable sway window manager
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.light.enable = true;
  programs.waybar.enable = true;
  programs.wshowkeys.enable = true;
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      source /etc/profile
      test -f $HOME/.profile && source $HOME/.profile
      export MOZ_ENABLE_WAYLAND=1
      systemctl --user import-environment
    '';
    extraPackages = with pkgs; [
      swayidle
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      mako # notification system developed by swaywm maintainer
      foot
      swaylock
      kanshi
      wofi
      ulauncher
      wf-recorder
      wl-mirror
      batsignal
      wlsunset
      playerctl
      wshowkeys
      zathura # pdf viewer
      libnotify
    ];
    wrapperFeatures.gtk = true;
  };
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "org.codeberg.dnkl.foot.desktop" ];
    };
  };
  xdg.mime.defaultApplications = {
    "application/pdf" = [ "zathura.desktop" "firefox.desktop" ];

  };

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # syncthing
  services.syncthing = {
    enable = true;
    user = "veirt";
  };

  # performance
  services.preload.enable = true;

  # tailscale
  networking.firewall.enable = true;
  networking.firewall.allowPing = false;
  services.tailscale.enable = true;
  systemd.services.tailscaled.wantedBy = pkgs.lib.mkForce [ ];

  # nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
  };
  nix.optimise.automatic = true;

  # gaming
  virtualisation.waydroid.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
