{ lib
, stdenv
, fetchFromGitHub
, wrapQtAppsHook
, qtbase
, qmake
, pkg-config
, Heaven
}:

stdenv.mkDerivation rec {
  pname = "Firmament";
  version = "2022-09-27";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = pname;
    rev = "01034e3172d96c5e8ca1c6373551b6f72ce6e324";
    hash = "sha256-vMuOLhA8MFlloZC9AoqxQFmB0zf20Z/K7Qo7ep1eWPQ=";
  };

  sourceRoot = "source/src";
  
  postPatch = ''
    # heaven-related paths are hardcoded
    substituteInPlace Firmament.pro \
      --replace "./../../Heaven/src/lib" "${Heaven}/include/Heaven" \
      --replace '/opt/''$''${TARGET}' '$$PREFIX'
      # ^ idek where to begin with this one TWT

    
    # meow meow meow meow meow meow meow   
    sed -i code/Action.h \
 	  	-e '/#include "Object.h"/a #include <QEnterEvent>'
  '';

  strictDeps = true;

  nativeBuildInputs = [
    wrapQtAppsHook
    qmake
    pkg-config
  ];
  
  buildInputs = [
    Heaven
    qtbase
  ];

  meta = with lib; {
    description = "Global menu bar for Cuarzo OS";
    homepage = "https://github.com/CuarzoSoftware/Firmament";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
