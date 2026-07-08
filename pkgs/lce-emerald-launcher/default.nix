{
  lib,
  stdenv,
  rustPlatform,
  fetchPnpmDeps,
  cargo-tauri,
  glib-networking,
  nodejs,
  pnpmBuildHook,
  pnpmConfigHook,
  openssl,
  pkg-config,
  webkitgtk_4_1,
  wrapGAppsHook4,
  fetchFromGitHub,
  pnpm_10,
  systemd,
  libappindicator,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "lce-emerald-launcher";
  version = "nightly-unstable-2026-07-07";
  src = fetchFromGitHub {
    owner = "LCE-Hub";
    repo = "LCE-emerald-launcher";
    rev = "f46453f1cdc6d9ea51c5e95e9ed9c9b77d72a67b";
    sha256 = "sha256-JbxshidGIhCYAq7vNX1eXPjWJ+m8DC2AAM66dPpHnBY=";
  };

  cargoHash = "sha256-6uSkFnAOnPIRm9jIU5ZvedHDGdkwX6m7HHoYyo6y4qI=";

  # Assuming our app's frontend uses `npm` as a package manager
  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-nY2DHKanLq6oe/NeWEdCU160OJ9srofVN34S/pfDk9I=";
  };

  nativeBuildInputs = [
    cargo-tauri.hook

    nodejs
    pnpmBuildHook
    pnpmConfigHook
    pnpm_10

    pkg-config
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ wrapGAppsHook4 ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking # Most Tauri apps need networking
    openssl
    systemd
    libappindicator
    webkitgtk_4_1
  ];
  postPatch = ''
    substituteInPlace src-tauri/tauri.conf.json \
      --replace-fail '"createUpdaterArtifacts": true' '"createUpdaterArtifacts": false'
  '';

  # Set our Tauri source directory
  cargoRoot = "src-tauri";
  # And make sure we build there too
  buildAndTestSubdir = finalAttrs.cargoRoot;
})
