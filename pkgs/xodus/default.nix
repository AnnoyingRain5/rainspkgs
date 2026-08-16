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
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "xodus-gaming";
    repo = "xodus";
    rev = "4615749c6e02cc3b9acce2abbe9916fe8c376f9a";
    sha256 = "sha256-4BNbNANSsKpiCVLYM8TPWpykum4RQ/cNmsHhiax6pdA=";
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
