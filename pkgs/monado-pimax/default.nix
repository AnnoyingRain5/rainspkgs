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
    rev = "e8f9a069f1d26ffa857846356d581edffd3ec4a9";
    hash = "sha256-wasoo99+bnCTeAWC0HqhVeKHjNIizKPDrfCGZwZYVT8=";
  };
  patches = builtins.filter (
    patch: patch.name != "monado-cylinder-aspectRatio.patch"
  ) oldAttrs.patches or [ ];
  cmakeFlags = [
    (lib.cmakeFeature "GIT_DESC" "Pimax-Fork")
  ];
})
