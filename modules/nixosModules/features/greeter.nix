{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # tuigreet: A retro-style terminal UI for logging in.
        # --time: Shows the current time in the corner.
        # --remember: Remembers the last user who logged in.
        # --cmd niri-session: Automatically starts Niri after a successful login.
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Standard Input/Output configuration for Systemd
  # This ensures the login screen has direct access to your keyboard/monitor (TTY)
  # and prevents boot logs from drawing over the login screen.
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
