#!/bin/bash

cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
git add hardware-configuration.nix

sudo nixos-rebuild switch --flake .#forgisOS

exit

git clone --depth 1 https://github.com/doomemacs/core ~/.config/emacs ; ~/.config/emacs/bin/doom install