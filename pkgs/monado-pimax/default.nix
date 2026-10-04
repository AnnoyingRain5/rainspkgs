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
    rev = "492c5e3c25f4fd8fc4b64d08b3c0787ccb2b59e0";
    hash = "sha256-GO5yGf092MFDK7R0++TgKOwmcp39cPK9pwmHs3RWNq4=";
  };
  patches = builtins.filter (
    patch: patch.name != "monado-cylinder-aspectRatio.patch"
  ) oldAttrs.patches or [ ];
  cmakeFlags = [
    (lib.cmakeFeature "GIT_DESC" "Pimax-Fork")
  ];
})
