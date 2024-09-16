{
  description = "My dotfiles, all my wisdom, my castle.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm-flake = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vim-overlay = {
      url = "github:kawarimidoll/vim-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      # self,
      nixpkgs,
      nixos-hardware,
      xremap-flake,
      home-manager,
      wezterm-flake,
      neovim-nightly-overlay,
      vim-overlay,
      ...
    }:
    let
      flakeRoot = ./.;
      nixpkgsOverlay = /${flakeRoot}/nix-overlays;

      # nixos directory symbols
      nixos = /${flakeRoot}/nixos;
      nixosSettings = /${nixos}/settings;

      # nix home-manager directory symbols
      homeManager = /${flakeRoot}/home-manager;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt-rfc-style;
      nixosConfigurations =
        let
          nixosSystemArgs =
            { path }:
            import path {
              inherit nixos-hardware xremap-flake nixosSettings;
            };
        in
        {
          laptop = nixpkgs.lib.nixosSystem (nixosSystemArgs {
            path = ./nixos/ThinkPadE14Gen2;
          });
          desktop = nixpkgs.lib.nixosSystem (nixosSystemArgs {
            path = ./nixos/Desktop;
          });
        };

      homeConfigurations =
        let
          homeManagerArgs =
            { profileName, system }:
            import ./home-manager {
              inherit
                profileName
                system
                nixpkgs
                wezterm-flake
                neovim-nightly-overlay
                vim-overlay
                flakeRoot
                nixpkgsOverlay
                homeManager
                ;
            };
        in
        {
          linux = home-manager.lib.homeManagerConfiguration (homeManagerArgs {
            profileName = "linux";
            system = "x86_64-linux";
          });
          macx64 = home-manager.lib.homeManagerConfiguration (homeManagerArgs {
            profileName = "macx64";
            system = "x86_64-darwin";
          });
        };
    };
}
