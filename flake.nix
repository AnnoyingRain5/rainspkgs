{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
  outputs =
    {
      self,
      nixpkgs,
      nix-cachyos-kernel,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      legacyPackages = forAllSystems (
        system:
        import ./default.nix {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ nix-cachyos-kernel.overlays.default ];
          };
          inherit nix-cachyos-kernel;
        }
      );
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
      nixosModules = import ./nixos-modules;
      # homeModules = import ./home-modules;
      # darwinModules = import ./darwin-modules;
      # flakeModules = import ./flake-modules;
    };
}
