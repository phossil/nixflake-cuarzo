{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  pkg-config,
  libglvnd,
  udev,
  libdrm,
  mesa,
  libdisplay-info,
  libinput,
  seatd,
  ninja,
}:

stdenv.mkDerivation rec {
  pname = "srm-cuarzo";
  version = "0.11.0-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "SRM";
    rev = "v${version}";
    hash = "sha256-9fs29Us2/Z6d4u0XHKaFUrjxuSDcp9zj+cyIlhAn0Eg=";
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
    seatd
  ];

  meta = with lib; {
    description = "C library for simplifying the development of Linux DRM/KMS applications";
    homepage = "https://cuarzosoftware.github.io/SRM/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.lgpl21Only;
  };
}
