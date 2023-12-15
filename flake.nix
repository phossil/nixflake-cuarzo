{
  description = "Cuarzo";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # these are yet to be added to nixpkgs
      packages.${system} = with pkgs; rec {
        SRM = callPackage ./packages/srm { };
        Louvre = callPackage ./packages/louvre {
          SRM = SRM;
        };
        Crystals = qt6Packages.callPackage ./packages/crystals {
          Louvre = Louvre;
          SRM = SRM;
        };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
