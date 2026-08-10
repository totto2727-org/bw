{
  description = "Standalone native MoonBit bw CLI";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    moonbit-overlay = {
      url = "github:totto2727/moonbit-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    moon-registry = {
      url = "git+https://mooncakes.io/git/index";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      moonbit-overlay,
      moon-registry,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          overlays = [ moonbit-overlay.overlays.default ];
        };
      mkBw = pkgs:
        pkgs.callPackage ./package.nix {
          moonRegistryIndex = moon-registry;
        };
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.moonbit-bin.moonbit.latest
            ];
          };
        }
      );

      packages = forEachSystem (
        system:
        let
          bw = mkBw (mkPkgs system);
        in
        {
          inherit bw;
          default = bw;
        }
      );

      overlays.default = _final: prev: {
        bw = self.packages.${prev.stdenv.hostPlatform.system}.bw;
      };
    };
}
