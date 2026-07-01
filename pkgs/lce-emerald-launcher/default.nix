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
  version = "1.4.1";
  src = fetchFromGitHub {
    owner = "LCE-Hub";
    repo = "LCE-emerald-launcher";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-YBco9tIsNq6Qv5PCB0u7PR9zTgIiaXqQEsygtit1HHY=";
  };

  cargoHash = "sha256-QxMD+oCc8BO4ayX5ma0gkJbcdI11XAZldvWcTxgb940=";

  # Assuming our app's frontend uses `npm` as a package manager
  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-MHAMGQSJtBEzi5E4pYqkUjZ8oQUTX7oMCf/JTTnaREQ=";
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
