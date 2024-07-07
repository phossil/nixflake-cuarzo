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
  version = "2.3.1-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = "Louvre";
    rev = "v${version}";
    hash = "sha256-00TRD6RcfVOjJFpUnGnu97nud6AHtz0tDWFxOwyYq88=";
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

  # Tbese can definitely be outputted in a better way but I am feeling lazy
  louvreViewsSession = writeText "louvre-views.desktop"
    ''
      [Desktop Entry]
      Name=louvre-views
      Comment=Louvre-based example resembling the macOS X desktop
      Exec=@out@/bin/louvre-views
      TryExec=@out@/bin/louvre-views
      Type=Application
      DesktopNames=louvre
    '';

  louvreWestonCloneSession = writeText "louvre-weston-clone.desktop"
    ''
      [Desktop Entry]
      Name=louvre-weston-clone
      Comment=Louvre-based example resembling weston
      Exec=@out@/bin/louvre-weston-clone
      TryExec=@out@/bin/louvre-weston-clone
      Type=Application
      DesktopNames=louvre
    '';

  # move xsession file to appropriate path
  postInstall = ''
    mkdir -p $out/share/wayland-sessions
    substitute ${louvreViewsSession} $out/share/wayland-sessions/louvre-views.desktop --subst-var out
    substitute ${louvreWestonCloneSession} $out/share/wayland-sessions/louvre-weston-clone.desktop --subst-var out
  '';

  passthru.providedSessions = [ "louvre-views" "louvre-weston-clone" ];

  meta = with lib; {
    description = "C++ library for building Wayland compositors";
    homepage = "https://cuarzosoftware.github.io/Louvre/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
