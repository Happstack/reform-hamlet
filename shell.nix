{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, blaze-markup, reform, shakespeare
      , stdenv, text
      }:
      mkDerivation {
        pname = "reform-hamlet";
        version = "0.0.5.1";
        src = ./.;
        libraryHaskellDepends = [
          base blaze-markup reform shakespeare text
        ];
        homepage = "http://www.happstack.com/";
        description = "Add support for using Hamlet with Reform";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
