{
  description = "NixOS base flake.nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nur = {
      url = "githAub:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
       url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ...} @ inputs: {
    nixosConfigurations.HoMM3Box = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        nur.modules.nixos.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.phantasm = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
