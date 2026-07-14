{
  monado,
  fetchFromGitLab,
  lib,
}:

monado.overrideAttrs (oldAttrs: {
  pname = "monado-pimax";
  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "AnnoyingRain5";
    repo = "monado";
    rev = "7c56b5c1723a223fb149e4d01967558c407e560e";
    hash = "sha256-tAG22s/RDvOkSd5LL30W9iu7KvEWBlA0+SDHwmipfTw=";
  };
  patches = builtins.filter (
    patch: patch.name != "monado-cylinder-aspectRatio.patch"
  ) oldAttrs.patches or [ ];
  cmakeFlags = [
    (lib.cmakeFeature "GIT_DESC" "Pimax-Fork")
  ];
})
