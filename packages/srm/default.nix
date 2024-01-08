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
  version = "0.4.0-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "SRM";
    rev = "v${version}";
    hash = "sha256-PWtDSBYw62sfyN2lpd7NY8SbqDrt5IN1rdLZRtDfals=";
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

  postPatch = ''
    # outdated(?) import
    substituteInPlace lib/SRMTypes.h \
      --replace "<drm_fourcc.h>" "<libdrm/drm_fourcc.h>"
  '';

  meta = with lib; {
    description = "C library for simplifying the development of Linux DRM/KMS applications";
    homepage = "https://cuarzosoftware.github.io/SRM/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
