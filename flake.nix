{
  description = "Cuarzo";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = inputs @ { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # these are yet to be added to nixpkgs:tm:, hopefully
      # ...
      #
      #
      #
      # pls dont steal b4 i commit to nixpkgs, leave some for me q q
      packages.${system} = with pkgs; rec {
        srm-cuarzo = callPackage ./packages/srm { };
        louvre = callPackage ./packages/louvre {
          inherit srm-cuarzo;
        };
        #crystals = qt6Packages.callPackage ./packages/crystals {
        #  inherit louvre srm-cuarzo;
        #};
        heaven = callPackage ./packages/heaven { };
        qtcuarzo = qt6Packages.callPackage ./packages/qtcuarzo {
          inherit heaven;
        };
        firmament = qt6Packages.callPackage ./packages/firmament {
          inherit heaven;
        };
        louvre-template = callPackage ./packages/louvre-template {
          inherit louvre;
        };
        desk = qt6Packages.callPackage ./packages/desk {
          layer-shell-qt = kdePackages.layer-shell-qt;
        };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosModules = {
        louvre-views = import ./modules/louvre-views.nix inputs;
      };
    };
}
