{
  pkgs,
  dolphin-emu,
  openxr-loader,
  lib,
}:

(dolphin-emu.overrideAttrs (oldattrs: {
  pname = "dolphin-xr";
  buildInputs = (oldattrs.buildInputs or [ ]) ++ [ openxr-loader ];
  src = pkgs.fetchFromGitHub {
    owner = "iChris4"; # https://github.com/iChris4/dolphinXR/pull/2
    repo = "dolphinXR";
    rev = "f500c46df1a1be9a1a4e2afc6c6eb78f0f6251bf";
    hash = "sha256-5kmQ9YOrAR5Zh/qpphqNIq9Lbh7CWHcp22zQR9ydwWo=";
    fetchSubmodules = true;
    leaveDotGit = true;
    postFetch = ''
      pushd $out
      git rev-parse HEAD 2>/dev/null >$out/COMMIT
      find $out -name .git -print0 | xargs -0 rm -rf
      popd
    '';
  };
  cmakeFlags = (oldattrs.cmakeFlags or [ ]) ++ [
    (lib.cmakeBool "ENABLE_VR" true)
  ];
  env.NIX_CFLAGS_COMPILE = "-fpermissive -fexceptions";
}))
