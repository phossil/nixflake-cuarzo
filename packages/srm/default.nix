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
  libgbm,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "srm-cuarzo";
  version = "0.13.0-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "SRM";
    tag = "v${finalAttrs.version}";
    hash = "sha256-5BwLqAZdfO5vyEMPZImaxymvLoNuu6bOiOkvR8JERxg=";
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
    libgbm
  ];

  meta = with lib; {
    description = "C library for simplifying the development of Linux DRM/KMS applications";
    homepage = "https://cuarzosoftware.github.io/SRM/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.lgpl21Only;
  };
})
