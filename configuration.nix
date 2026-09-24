{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "forgisOS";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  services.xserver = {
    enable = true;
    xkb.layout = "es";

    windowManager.i3.enable = true;
  };

  console.keyMap = "es";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      save = true;
      load = true;
    };
  };

  programs.zsh.enable = true;

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
