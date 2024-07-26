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
  version = "0-2024-07-08";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "LouvreTemplate";
    rev = "76157a75f44fca9c11d6691f1035ccc0526f0102";
    hash = "sha256-5PfWmatwiwLpR59u07H0GC799LHWJt1ZLy5mCDKQqns=";
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
