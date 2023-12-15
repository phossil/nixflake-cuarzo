{ lib
, stdenv
, fetchFromGitHub
, wrapQtAppsHook
, qtbase
, qmake
, pkg-config
, Louvre
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
  pname = "Crystals";
  version = "2023-07-06";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = pname;
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
    Louvre
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
    # confused packager noises ???:
    # In file included from code/Output.cpp:8:
    # code/View.h:25:1: error: expected class-name before '{' token
    #    25 | {
    #       | ^
    broken = true;
    description = "Wayland compositor for Cuarzo OS";
    homepage = "https://github.com/CuarzoSoftware/Crystals";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    # license is currently undefined upstream
    #license = licenses.???;
  };
}
