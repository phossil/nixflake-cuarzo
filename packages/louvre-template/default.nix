{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  louvre,
  pixman,
  libinput,
  systemdLibs,
  wayland,
  libglvnd,
  libxkbcommon,
  libdrm,
}:

stdenv.mkDerivation rec {
  pname = "louvre-template";
  version = "0-unstable-2024-07-24";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "LouvreTemplate";
    rev = "21ab255851acc3ffc26c5a6d6f9846855c678928";
    hash = "sha256-M42cwfQguzfpeG9vm79hvrw5Nr/la4db2D/hErf+Nok=";
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
