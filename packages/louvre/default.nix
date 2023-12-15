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
, SRM
, freeimage
, fontconfig
, icu
}:

stdenv.mkDerivation rec {
  pname = "Louvre";
  version = "1.0.1-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = pname;
    # the release version would be used but their custom meson options
    # conflict with file persmissions when installing to the nix store
    rev = "68cf8dd9290ea1ec68d46b3be2a89a83e261b79c";
    hash = "sha256-lgeOb+RofEbw+x2Lx80a78TQFEL0u2mnyZoMSLshuUU=";
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
    SRM
    freeimage
    xorg.xorgproto
    fontconfig
    icu
    xorg.libX11
  ];

  meta = with lib; {
    description = "C++ library for building Wayland compositors";
    homepage = "https://cuarzosoftware.github.io/Louvre/";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Only;
  };
}
