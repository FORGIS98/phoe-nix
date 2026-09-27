{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "DejaVu Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    blueman
    pavucontrol
    pulseaudio
    appimage-run
    android-tools
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "forgisOS";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;

  time.timeZone = "Europe/Madrid";

  services.xserver = {
    enable = true;
    xkb.layout = "es";
    videoDrivers = [ "nvidia" ];

    windowManager.i3.enable = true;
  };

  hardware.graphics.enable = true;

  # Driver propietario de NVIDIA para la RTX 4070 (AD104, Ada Lovelace usa nouveau por defecto)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  console.keyMap = "es";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      numlock = true;
      save = true;
      load = true;
    };
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  users.users.jorge = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  i18n.defaultLocale = "es_ES.UTF-8";
  
  i18n.supportedLocales = [
    "es_ES.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LANGUAGE = "es_ES.UTF-8:es";
    LC_ALL = "es_ES.UTF-8";
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  system.stateVersion = "26.05";
}
