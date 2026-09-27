#!/bin/bash

cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
git add hardware-configuration.nix

sudo nixos-rebuild switch --flake .#forgisOS

echo "respira 5 segundos..." ; sleep 5

git clone --depth 1 https://github.com/doomemacs/core ~/.config/emacs && ~/.config/emacs/bin/doom install