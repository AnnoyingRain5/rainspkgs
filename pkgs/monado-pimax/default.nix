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
    rev = "e95624e1ff97e70ae30316c3f537af88a4e34e8a";
    hash = "sha256-0CwfIo/FpN8B62KeOp7AIXniCtV1h3wO4WPLJk/qQiM=";
  };
  patches = builtins.filter (
    patch: patch.name != "monado-cylinder-aspectRatio.patch"
  ) oldAttrs.patches or [ ];
  cmakeFlags = [
    (lib.cmakeFeature "GIT_DESC" "Pimax-Fork")
  ];
})
