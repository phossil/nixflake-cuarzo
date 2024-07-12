{ lib
, stdenv
, fetchFromGitHub
, meson
, pkg-config
, libglvnd
, udev
, libdrm
, mesa
, libdisplay-info
, libinput
, libseat
, ninja
}:

stdenv.mkDerivation rec {
  pname = "srm-cuarzo";
  version = "0.6.3-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "SRM";
    rev = "v${version}";
    hash = "sha256-nQucfh/Eri2BM70NFYqJQnBgVlHO/5eNHVFX/6RYoZA=";
  };

  sourceRoot = "source/src";

  strictDeps = true;

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
  ];

  buildInputs = [
    libglvnd
    udev
    libdrm
    mesa
    libdisplay-info
    libinput
    libseat
  ];

  meta = with lib; {
    description = "C library for simplifying the development of Linux DRM/KMS applications";
    homepage = "https://cuarzosoftware.github.io/SRM/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
