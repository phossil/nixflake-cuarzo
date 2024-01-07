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
, fontconfig
, icu
, writeText
}:

stdenv.mkDerivation rec {
  pname = "Louvre";
  version = "1.1.0-1";

  src = fetchFromGitHub {
    owner = "CuarzoSoftware";
    repo = pname;
    # the release version would be used but their custom meson options
    # conflict with file persmissions when installing to the nix store
    rev = "v${version}";
    hash = "sha256-HwvX0ykl2+4MBcIixmEknFtsB0QC4w1QDzQz1589bl0=";
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
