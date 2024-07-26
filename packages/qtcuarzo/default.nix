{
  lib,
  stdenv,
  fetchFromGitHub,
  wrapQtAppsHook,
  qtbase,
  cmake,
  pkg-config,
  heaven,
  qtdeclarative,
}:

stdenv.mkDerivation rec {
  pname = "qtcuarzo";
  version = "2022-09-27";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "QtCuarzo";
    rev = "e033ec90e95d51ef261cce33f64598b0cb5c7fea";
    hash = "sha256-KUw+kJX7U1QhBXWEhEFMi+JvrFc4pH7dQmBlyIFHlNY=";
  };

  sourceRoot = "source/src";

  strictDeps = true;

  env.NIX_CFLAGS_COMPILE = toString [ "-I${heaven}/include/Heaven" ];

  postPatch = ''
    # qt plugin path is hardcoded
    substituteInPlace CMakeLists.txt \
      --replace "/usr/lib/x86_64-linux-gnu/qt5/plugins" \
                "\''${CMAKE_INSTALL_PREFIX}/${qtbase.qtPluginPrefix}"
  '';

  nativeBuildInputs = [
    wrapQtAppsHook
    cmake
    pkg-config
  ];

  buildInputs = [
    heaven
    qtdeclarative
    qtbase
  ];

  meta = with lib; {
    description = "Qt Platform Theme for Cuarzo OS";
    homepage = "https://github.com/CuarzoSoftware/QtCuarzo";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
