{
  lib,
  stdenv,
  fetchFromGitHub,
  libepoxy,
  wxwidgets_3_3,
  portaudio,
  pkg-config,
  unstableGitUpdater,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "3beans";
  version = "0-unstable-2026-06-11";

  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "Hydr8gon";
    repo = "3Beans";
    rev = "83a0896d0ae3a18d2ace93d41f91e6b8cb46bea3";
    sha256 = "sha256-HUXJt/HulLYsgaK3AlpRpJy1Wsgtgoffr5LqJLun4sg=";
  };

  nativeBuildInputs = [
    pkg-config
    wxwidgets_3_3
  ];
  buildInputs = [
    libepoxy
    wxwidgets_3_3
    portaudio
  ];

  installPhase = ''
    runHook preInstall
    make install DESTDIR=$out
    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { hardcodeZeroVersion = true; };

  meta = {
    description = "Low-level 3DS emulator";
    homepage = "https://github.com/Hydr8gon/3Beans";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "3beans";
    #maintainers = with lib.maintainers; [ annoyingrains ];
  };
})
