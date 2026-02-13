{ pkgs, ... }: {
  # Enables the Niri tiling compositor
  # This also handles the creation of a 'niri-session' desktop entry
  # so that display managers (like greetd) can find it.
  programs.niri.enable = true;

  # List packages specifically needed for your GUI environment
  environment.systemPackages = with pkgs; [
    xwayland # Allows running older apps that don't support Wayland natively
    wayland-utils # Useful for debugging wayland protocols
  ];
}
