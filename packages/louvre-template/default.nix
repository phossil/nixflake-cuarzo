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

stdenv.mkDerivation {
  pname = "louvre-template";
  version = "0-unstable-2025-06-03";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "LouvreTemplate";
    rev = "cf0b8e458c94423fd40329a4626175db41e4a521";
    hash = "sha256-vt3jk0641iRs4ZgnDCBX592AbosZ95g7YAwk+VJpqLA=";
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
