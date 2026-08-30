{
  fetchFromGitHub,
  dolphin-emu,
  openxr-loader,
  lib,
}:

(dolphin-emu.overrideAttrs (oldattrs: {
  # note : this fails to compile with fmt 12.2.0 and above https://github.com/NixOS/nixpkgs/commit/98f1bcdc7d3fd51ada7d3a08d2e96886bb046a1e
  pname = "dolphin-xr";
  buildInputs = (oldattrs.buildInputs or [ ]) ++ [ openxr-loader ];
  src = fetchFromGitHub {
    owner = "iChris4";
    repo = "dolphinXR";
    rev = "85c4266b29eb308d173fefa0f21f5cb77df3516a";
    hash = "sha256-upMspxyggFdIiZLvwdxH/hehhMgU2Wx/tHkEWofykTU=";
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
