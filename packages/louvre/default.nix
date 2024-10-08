{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  pkg-config,
  ninja,
  wayland,
  libglvnd,
  udev,
  xorg,
  libxkbcommon,
  pixman,
  libdrm,
  mesa,
  libinput,
  libseat,
  srm-cuarzo,
  fontconfig,
  icu,
  writeText,
}:

stdenv.mkDerivation rec {
  pname = "louvre";
  version = "2.9.0-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Louvre";
    rev = "v${version}";
    hash = "sha256-0M1Hl5kF8r4iFflkGBb9CWqwzauSZPVKSRNWZKFZC4U=";
  };

  sourceRoot = "source/src";

  strictDeps = true;

  postPatch = ''
    # outdated(?) import
    substituteInPlace lib/core/LTexture.h \
      --replace-warn "<drm_fourcc.h>" "<libdrm/drm_fourcc.h>"
    substituteInPlace backends/graphic/DRM/LGraphicBackendDRM.cpp \
      --replace-warn "<drm_fourcc.h>" "<libdrm/drm_fourcc.h>"

    # fix output path
    substituteInPlace examples/meson.build \
      --replace-warn "/usr/local" "$out"
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

  passthru.providedSessions = [ "louvre" ];

  meta = with lib; {
    description = "C++ library for building Wayland compositors";
    homepage = "https://cuarzosoftware.github.io/Louvre/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
