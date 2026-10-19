{
  pkg-config,
  protobuf,
  openssl,
  dbus,
  glib,
  gtk3,
  libsoup_3,
  webkitgtk_4_1,
  glib-networking,
  wrapGAppsHook4,
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "xodus";
  version = "0-unstable-2026-10-06";

  src = fetchFromGitHub {
    owner = "xodus-gaming";
    repo = "xodus";
    rev = "53ea781dcd073e31d7ea68e894134e9c959bff04";
    sha256 = "sha256-3nR/bvfVMLZEgmO9GQoGvJwvDjVFpEt55MucTdXAdTE=";
  };

  cargoHash = "sha256-Dpk8DOXTXpxB0IAf2+d9yLPB0XdS5oa5ESgjTjLO4H4=";

  nativeBuildInputs = [
    pkg-config
    protobuf
    #cargo-tauri.hook
    wrapGAppsHook4
  ];

  buildInputs = [
    glib-networking
    openssl
    dbus
    glib
    gtk3
    libsoup_3
    webkitgtk_4_1
  ];
  doCheck = false;

  meta = {
    description = "The great gaming migration to Linux";
    homepage = "https://github.com/xodus-gaming/xodus";
    license = lib.licenses.gpl3;
  };
}
