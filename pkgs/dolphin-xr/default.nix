{
  pkgs,
  dolphin-emu,
  openxr-loader,
}:

(dolphin-emu.overrideAttrs (oldattrs: {
  pname = "dolphin-xr";
  buildInputs = (oldattrs.buildInputs or [ ]) ++ [ openxr-loader ];
  src = pkgs.fetchFromGitHub {
    owner = "AnnoyingRain5"; # https://github.com/iChris4/dolphinXR/pull/2
    repo = "dolphinXR";
    rev = "7486f8ec05621f658eb6422c0e42ece96d303491";
    hash = "sha256-2Zyw8kj0Zc2YrmZbqW2Ai3YQdUGOJR01beH13LkJBCc=";
    fetchSubmodules = true;
    deepClone = false;
    leaveDotGit = true;
    postFetch = ''
      pushd $out
      git rev-parse HEAD 2>/dev/null >$out/COMMIT
      find $out -name .git -print0 | xargs -0 rm -rf
      popd
    '';
  };
  #postPatch = ''
  #  # Remove the OpenXR submodule directory so it uses system package instead
  #  rm -rf Externals/OpenXR
  #'';
  meta.broken = true;
}))
