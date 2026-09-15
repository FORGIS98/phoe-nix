{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "forgisOS";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  programs.zsh.enable = true;

  users.users.jorge = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "26.05";
}
