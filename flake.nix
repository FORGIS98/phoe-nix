{
  description = "phoe-nix: Configuración unificada para NixOS y Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # sudo nixos-rebuild switch --flake .#forgisOS
    nixosConfigurations = {
      forgisOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jorge = import ./home.nix;
          }
        ];
      };
    };

    # (non nixOS computers) home-manager switch --flake .#jorge
    homeConfigurations = {
      "jorge" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./home.nix ];
      };
    };

    # entorno basico al entrar al repo (direnv: use flake)
    devShells."x86_64-linux".default =
      let pkgs = nixpkgs.legacyPackages."x86_64-linux";
      in pkgs.mkShell {
        packages = with pkgs; [
          lua
          luajit
          python3
          nodejs
          gnumake
          gcc
          nixfmt
          statix
          deadnix
          luaPackages.luacheck
          stylua
          emacs-nox
          shellcheck
          shfmt
          jq
          ruff
        ];
      };

  };
}
