{ config, pkgs, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/phoe-nix";
in
{
  home.username = "jorge";
  home.homeDirectory = "/home/jorge";

  home.packages = with pkgs; [
    oh-my-zsh
    kitty
    neovim
    emacs
    firefox
    i3
    i3status
    openssh
    rofi
    feh
    
    # doom-emacs
    ripgrep
    fd
    coreutils
    clang
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "FORGIS98";
      user.email = "jorgesolgonzalez1998@gmail.com";

      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  imports = [
    ./config/zsh/zsh.nix
  ];

  services.ssh-agent.enable = true;

  home.file = {
    ".config/doom".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/doom";
  };

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
