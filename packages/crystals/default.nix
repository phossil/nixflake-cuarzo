{
  lib,
  stdenv,
  fetchFromGitHub,
  wrapQtAppsHook,
  qtbase,
  qmake,
  pkg-config,
  louvre,
  wayland,
  libglvnd,
  udev,
  xorg,
  libxkbcommon,
  pixman,
  libdrm,
  mesa,
  libinput,
  seatd,
  srm-cuarzo,
  freeimage,
  fontconfig,
  icu,
}:

stdenv.mkDerivation {
  pname = "crystals";
  version = "0-unstable-2023-07-06";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Crystals";
    rev = "c0cec31e62b3c3747098a608fa75d3d11d728acf";
    hash = "sha256-b8wHMPY/NSfXTaxBVn5drgkj8SZlckAs2lzXzlCDzIA=";
  };

  sourceRoot = "source/src";

  postPatch = ''
    # include paths are hardcoded
    substituteInPlace Crystals.pro \
      --replace "/usr/include" "${Louvre}/include"
  '';

  strictDeps = true;

  nativeBuildInputs = [
    wrapQtAppsHook
    qmake
    pkg-config
  ];

  buildInputs = [
    qtbase
    louvre
    wayland
    libglvnd
    udev
    xorg.libXcursor
    libxkbcommon
    pixman
    libdrm
    mesa
    libinput
    seatd
    srm-cuarzo
    freeimage
    xorg.xorgproto
    fontconfig
    icu
    xorg.libX11
  ];

  meta = with lib; {
    # it's basically a really outdated and incomplete version of what would
    # become the louvre-views demo
    broken = true;
    description = "Wayland compositor for Cuarzo OS";
    homepage = "https://github.com/CuarzoSoftware/Crystals";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    # license is currently undefined upstream
    #license = licenses.???;
  };
}
