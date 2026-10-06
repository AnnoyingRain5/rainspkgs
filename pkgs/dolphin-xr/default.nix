{
  fetchFromGitHub,
  dolphin-emu,
  openxr-loader,
  lib,
  oldfmt,
  bzip2,
  cubeb,
  curl,
  enet,
  ffmpeg,
  glslang,
  gtest,
  hidapi,
  libxdmcp,
  libpulseaudio,
  libspng,
  libusb1,
  lz4,
  lzo,
  miniupnpc,
  minizip-ng,
  openal,
  pugixml,
  qt6,
  sdl3,
  sfml,
  xxhash,
  xz,
  zlib-ng,
  alsa-lib,
  bluez,
  libGL,
  libxext,
  libxrandr,
  libevdev,
  udev,
  vulkan-loader,
  moltenvk,
  stdenv,
}:

(dolphin-emu.overrideAttrs (oldattrs: {
  # note : this fails to compile with fmt 12.2.0 and above https://github.com/NixOS/nixpkgs/commit/98f1bcdc7d3fd51ada7d3a08d2e96886bb046a1e
  pname = "dolphin-xr";
  buildInputs = [
    bzip2
    cubeb
    curl
    enet
    ffmpeg
    openxr-loader
    glslang
    gtest
    hidapi
    libxdmcp
    libpulseaudio
    libspng
    libusb1
    lz4
    lzo
    #mbedtls_2 # Use vendored, as using nixpkgs' would mark the package unsafe
    miniupnpc
    minizip-ng
    openal
    pugixml
    qt6.qtbase
    qt6.qtsvg
    sdl3
    sfml
    xxhash
    xz
    zlib-ng
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    alsa-lib
    bluez
    libGL
    libxext
    libxrandr
    libevdev
    # FIXME: Vendored version is newer than mgba's stable release, remove the comment on next mgba's version
    #mgba # Derivation doesn't support Darwin
    udev
    vulkan-loader
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    moltenvk
  ];
  src = fetchFromGitHub {
    owner = "iChris4";
    repo = "dolphinXR";
    rev = "576f268fb88e890082ead57f60c2e3d033013198";
    hash = "sha256-yD7lywySZkqEhAdwdUcufcA+pV2vlyv2JEtRIsz4iuc=";
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
