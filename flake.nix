{
  description = "Cuarzo";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }:
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
          srm-cuarzo = srm-cuarzo;
        };
        #crystals = qt6Packages.callPackage ./packages/crystals {
        #  louvre = louvre;
        #  srm-cuarzo = srm-cuarzo;
        #};
        heaven = callPackage ./packages/heaven { };
        qtcuarzo = qt6Packages.callPackage ./packages/qtcuarzo {
          heaven = heaven;
        };
        firmament = qt6Packages.callPackage ./packages/firmament {
          heaven = heaven;
        };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
