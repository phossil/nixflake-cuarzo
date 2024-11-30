{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  wrapQtAppsHook,
  qtbase,
  pkg-config,
  layer-shell-qt,
  ninja,
  qttools,
}:

stdenv.mkDerivation rec {
  pname = "desk";
  version = "0-unstable-2024-06-22";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Desk";
    rev = "576ed71b504e09314551393670f4afe063541710";
    hash = "sha256-2ryIgPufQDlUe6z7uZhXkUkbLZaSS8dGA9YvhprAomQ=";
  };

  patches = [ ./meson-install.patch ];

  strictDeps = true;

  nativeBuildInputs = [
    meson
    wrapQtAppsHook
    pkg-config
    ninja
    qttools
  ];

  buildInputs = [
    qtbase
    layer-shell-qt
  ];

  meta = with lib; {
    description = "CuarzoOS file manager";
    homepage = "https://github.com/CuarzoSoftware/Desk";
    mainProgram = "cuarzo-desk";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
