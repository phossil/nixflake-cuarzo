{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, louvre
, pixman
, libinput
, systemdLibs
, wayland
, libglvnd
, libxkbcommon
, libdrm
}:

stdenv.mkDerivation rec {
  pname = "louvre-template";
  version = "2024-06-26";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "LouvreTemplate";
    rev = "1190dd549b95082dabc8b1b04de8c6997c6731df";
    hash = "sha256-risymnW94uE+MR70nshD/y7FolK9jTphFeQdU3OUZzI=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    louvre
    pixman
    libinput
    systemdLibs
    wayland
    libglvnd
    libxkbcommon
    libdrm
  ];

  meta = with lib; {
    description = "Example wayland compositor based on Louvre";
    homepage = "https://cuarzosoftware.github.io/Louvre/tutorial_tmp.html";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
