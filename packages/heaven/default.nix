{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "heaven";
  version = "2022-09-27";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Heaven";
    rev = "22e52e01bb5855c79fa3381804b795855385be86";
    hash = "sha256-y6+aGCX1HowyJI4hIu0fMwZOKssgpXpsfXO6M3E5rWA=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "C library for exposing global menus in Wayland and X11 sessions";
    homepage = "https://github.com/CuarzoSoftware/Heaven";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
