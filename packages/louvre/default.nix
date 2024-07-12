{ lib
, stdenv
, fetchFromGitHub
, meson
, pkg-config
, ninja
, wayland
, libglvnd
, udev
, xorg
, libxkbcommon
, pixman
, libdrm
, mesa
, libinput
, libseat
, srm-cuarzo
, fontconfig
, icu
, writeText
}:

stdenv.mkDerivation rec {
  pname = "louvre";
  version = "2.3.2-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Louvre";
    rev = "v${version}";
    hash = "sha256-Wpc9CDNNA8+pMcdVkquYIS3qyern59OH/bWchcpiVDo=";
  };

  sourceRoot = "source/src";

  strictDeps = true;

  postPatch = ''
    # outdated(?) import
    substituteInPlace lib/core/LTexture.h \
      --replace "<drm_fourcc.h>" "<libdrm/drm_fourcc.h>"
  '';

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
  ];

  buildInputs = [
    wayland
    libglvnd
    udev
    xorg.libXcursor
    libxkbcommon
    pixman
    libdrm
    mesa
    libinput
    libseat
    srm-cuarzo
    xorg.xorgproto
    fontconfig
    icu
    xorg.libX11
  ];

  outputs = [ "out" "bin" ];

  meta = with lib; {
    description = "C++ library for building Wayland compositors";
    homepage = "https://cuarzosoftware.github.io/Louvre/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
