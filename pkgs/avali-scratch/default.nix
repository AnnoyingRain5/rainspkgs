{ stdenv, lib }:

stdenv.mkDerivation {
  name = "avali-scratch";
  version = "1.0";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = ./.;
  };
  buildPhase = "";
  installPhase = ''
    ls
    mkdir -p $out/share/fonts/opentype/avali-scratch
    install -m444 -Dt $out/share/fonts/opentype/avali-scratch avali-scratch.otf
    install -m444 -Dt $out/share/fonts/opentype/avali-scratch license
    #cp font/avali-scratch.otf $out/share/fonts/opentype/avali-scratch
  '';
}
