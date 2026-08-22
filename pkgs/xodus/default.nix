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
  version = "0-unstable-2026-08-18";

  src = fetchFromGitHub {
    owner = "xodus-gaming";
    repo = "xodus";
    rev = "77d81f35f08b1bd84712d4e7515c274cee1b1428";
    sha256 = "sha256-0RuWSKevjdHfqNISj233h/YS7Ax5WripPgBxSGNyaV4=";
  };

  cargoHash = "sha256-VenzKiQlyNGsT3bS4wuZmpbEm9KL3dv5JeVtngoZeec=";

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
    maintainers = with lib.maintainers; [ annoyingrains ];
  };
}
