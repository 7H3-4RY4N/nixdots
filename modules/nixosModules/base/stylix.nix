{ pkgs, ... }: {
  stylix = {
    enable = true;
    enableReleaseChecks = false; 

    # You MUST have a wallpaper file in your nixdots folder for Stylix to work.
    # Replace "wallpaper.jpg" with your actual file name.
    image = ../../../gruvbox_nix.png;
     
    # Setting the theme to Gruvbox
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    # Global Polarity (ensures apps prefer dark mode)
    polarity = "dark";

    # Cursor settings
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # Font settings - This will apply to Kitty, Waybar, etc.
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 13;
        desktop = 11;
        popups = 10;
      };
    };

    # This auto-themes QT and GTK apps
    targets.gtk.enable = true;
    targets.gnome.enable = true;
  };
}
