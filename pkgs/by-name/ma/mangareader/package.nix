{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
  nix-update-script,
}:

stdenv.mkDerivation rec {
  pname = "mangareader";
  version = "2.2.2";

  src = fetchFromGitHub {
    owner = "g-fb";
    repo = "mangareader";
    rev = version;
    hash = "sha256-e5mG286Pj4Ey1/VzRxzXsY3bqI3XA0IBtnFTXwas/0s=";
  };

  nativeBuildInputs = [
    cmake
    kdePackages.extra-cmake-modules
    kdePackages.wrapQtAppsHook
  ];

  buildInputs = with kdePackages; [
    qtbase
    kio
    ki18n
    kxmlgui
    kconfig
    karchive
    kcoreaddons
    kconfigwidgets
    qtwayland
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Qt manga reader for local files";
    homepage = "https://github.com/g-fb/mangareader";
    changelog = "https://github.com/g-fb/mangareader/releases/tag/${src.rev}";
    mainProgram = "mangareader";
    platforms = lib.platforms.linux;
    license = with lib.licenses; [
      gpl3Plus
      cc-by-sa-40
    ];
    maintainers = with lib.maintainers; [ zendo ];
  };
}
