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
  version = "1.6.1-unstable-2026-08-18";
  src = fetchFromGitHub {
    owner = "LCE-Hub";
    repo = "LCE-emerald-launcher";
    rev = "d35927cf5b1589051072439ecfbb150dc031ca4c";
    sha256 = "sha256-9/CzBW5qlly6iG6FaGXBgW2Tq7gVszAIRAf0VcBILFc=";
  };

  cargoHash = "sha256-GfDuleIaeq6dpSzg4wWlClY2iYM5izbGv1febKuCh7I=";

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
    glib-networking
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

  meta = {
    mainProgram = "emerald-legacy-launcher";
  };
})
