{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.louvre-views;

  inherit (pkgs.stdenv.hostPlatform) system;

  louvre = self.packages.${system}.louvre;

  louvreViewsSessionFile =
    (pkgs.writeTextDir "share/wayland-sessions/louvre-views.desktop" ''
      [Desktop Entry]
      Name=louvre-views
      Comment=Louvre-based example resembling the macOS X desktop
      Exec=${louvre.bin}/bin/louvre-views
      TryExec=${louvre.bin}/bin/louvre-views
      Type=Application
      DesktopNames=louvre
    '').overrideAttrs (_: { passthru.providedSessions = [ "louvre-views" ]; });
in
{
  meta.maintainers = with lib.maintainers; [ phossil ];

  options.programs.louvre-views = {
    enable = mkEnableOption "Enables the Louvre Views demo";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ louvre pkgs.weston ];

    hardware.opengl.enable = lib.mkDefault true;
    fonts.enableDefaultPackages = lib.mkDefault true;
    programs.xwayland.enable = lib.mkDefault true;
    xdg.portal.config.wlroots.default = lib.mkDefault [ "wlr" ];

    services.displayManager.sessionPackages = [ louvreSessionFile ];
  };
}
