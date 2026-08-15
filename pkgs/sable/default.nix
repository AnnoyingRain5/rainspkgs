{
  lib,
  stdenv,
  rustPlatform,
  fetchPnpmDeps,
  pnpm_10,
  nodejs,
  libayatana-appindicator,
  glib,
  glibc,
  cargo-tauri,
  glib-networking,
  pnpmBuildHook,
  pnpmConfigHook,
  openssl,
  pkg-config,
  webkitgtk_4_1,
  wrapGAppsHook4,
  fetchFromGitHub,
  desktop-file-utils,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "sable";
  version = "0-unstable";

  src = fetchFromGitHub {
    owner = "SableClient";
    repo = "Sable";
    rev = "f68062311329f2ed6f160e6ca1425427191c0806";
    sha256 = "sha256-G2B+P8Mh3DwIhfxAIZBqEh1mYlZyA/5U5fqTxmrolxk=";
  };

  cargoHash = "sha256-7w2FXvhAG1WrVoH3uUuGansGIn/8z8qdu3C44yHM6/A=";

  # Assuming our app's frontend uses `npm` as a package manager
  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-3jfiIjSoXFN4vtp84FZ3ZhvIoI7YVw31Larmsa96Tzc=";
  };

  nativeBuildInputs = [
    # Pull in our main hook
    cargo-tauri.hook
    libayatana-appindicator
    # Setup npm
    pnpmBuildHook
    pnpmConfigHook
    pnpm_10
    nodejs

    # Make sure we can find our libraries
    pkg-config
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ wrapGAppsHook4 ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking # Most Tauri apps need networking
    glib
    glibc
    libayatana-appindicator
    openssl
    webkitgtk_4_1
    desktop-file-utils
  ];

  postPatch = ''
    substituteInPlace src-tauri/tauri.conf.json \
      --replace-fail '"createUpdaterArtifacts": true' '"createUpdaterArtifacts": false'
  '';
  postInstall = ''
    gappsWrapperArgs+=(
      --prefix PATH : "${lib.makeBinPath [ desktop-file-utils ]}"
    )
  '';

  # Set our Tauri source directory
  cargoRoot = "src-tauri";
  # And make sure we build there too
  buildAndTestSubdir = finalAttrs.cargoRoot;

  meta = {
    mainProgram = "sable";
    broken = true;
  };
})
