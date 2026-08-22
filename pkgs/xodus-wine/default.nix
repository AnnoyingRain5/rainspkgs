{
  wineWow64Packages,
  fetchgit,
  autoconf,
  perl,
  python3,
  lib,
  util-linux,
  git,
}:

(wineWow64Packages.base.override {
  wineRelease = "stable";
}).overrideAttrs
  (old: {
    src = fetchgit {
      url = "https://github.com/xodus-gaming/wine.git";
      rev = "b1dd32734a34472a28eb5be9922df06e07ac0834";
      hash = "sha256-fYZpkloInF4zPhgMasERubyZHOFQGxoDxyh2M/a30eg=";
      leaveDotGit = true;
    };
    version = "11.0-xodus";
    patches = [ ];

    nativeBuildInputs = old.nativeBuildInputs ++ [
      perl
      autoconf
      git
      util-linux
      python3
    ];

    preConfigure = (old.preConfigure or "") + ''
      export HOME=$TMPDIR
      patchShebangs dlls/winevulkan/
      patchShebangs tools
      ./autogen.sh
      tools/make_makefiles
    '';
    meta = {
      broken = true;
    };
  })
