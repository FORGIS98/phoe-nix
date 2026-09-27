{ config, pkgs, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/phoe-nix";
in
{
  home.username = "jorge";
  home.homeDirectory = "/home/jorge";

  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/Escritorio";
    documents = "${config.home.homeDirectory}/Documentos";
    download = "${config.home.homeDirectory}/Descargas";
    music = "${config.home.homeDirectory}/Música";
    pictures = "${config.home.homeDirectory}/Imágenes";
    publicShare = "${config.home.homeDirectory}/Público";
    projects = "${config.home.homeDirectory}/Proyectos";
    templates = "${config.home.homeDirectory}/Plantillas";
    videos = "${config.home.homeDirectory}/Vídeos";
  };

  home.packages = with pkgs; [
    oh-my-zsh
    kitty
    neovim
    emacs
    firefox
    telegram-desktop
    android-studio
    openssh
    rofi
    feh
    tree
    bat
    i3lock
    maim
    imagemagick
    jq
    
    # BEGIN doom-emacs dependencies
    ripgrep
    fd
    coreutils
    clang
    # END doom-emacs dependencies

  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
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
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/i3";
    ".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/vscode/settings.json";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/nvim";
  };

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
