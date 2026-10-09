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
    rev = "0c85c422f77647356c136ee032be256be73637c8";
    hash = "sha256-Z/1ZdvNsAOB1dGqAYE1yL8dkanxr/LjrzFM8yolqsac=";
  };
  patches = builtins.filter (
    patch: patch.name != "monado-cylinder-aspectRatio.patch"
  ) oldAttrs.patches or [ ];
  cmakeFlags = [
    (lib.cmakeFeature "GIT_DESC" "Pimax-Fork")
  ];
})
