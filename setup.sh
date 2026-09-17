cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
git add hardware-configuration.nix

sudo nixos-rebuild switch --flake .#forgisOS