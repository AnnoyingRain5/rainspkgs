{ pkgs, fetchzip }:

(pkgs.proton-ge-bin.override {
  steamDisplayName = "GE-Proton-GDK";
}).overrideAttrs
  (
    finalAttrs: _: {
      pname = "proton-ge-gdk-bin";
      version = "GE-Proton10-32";
      src = fetchzip {
        url = "https://github.com/Weather-OS/GDK-Proton/releases/download/release10-32/GDK-Proton10-32.tar.gz";
        sha256 = "sha256:03b1f9y61j9a4mqav6g5wxgmncicv1a9cd76xdjigzir8a5fx8n7";
      };
    }
  )
