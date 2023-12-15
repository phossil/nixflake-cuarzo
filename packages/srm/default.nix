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
  pname = "SRM";
  version = "0.3.2-2";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-9+P+nEZ+nmtViJWAuZ1RXd5E0avudDyejs5B95cbwe4=";
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
    description = "Simple Rendering Manager";
    homepage = "https://cuarzosoftware.github.io/SRM/";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
  };
}
