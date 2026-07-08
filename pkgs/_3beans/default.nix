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
  version = "0-unstable-2026-07-05";

  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "Hydr8gon";
    repo = "3Beans";
    rev = "5b50adc0b028ecc3dd83f1efd1804cd2e301fdaa";
    sha256 = "sha256-tdh6x6MmKsKJ4YasklV/AT04tInsy0QrH7xvTFacqZE=";
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
