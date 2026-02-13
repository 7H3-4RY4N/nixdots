{ lib, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    
    # Your custom keymaps
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    settings = {
      # --- Performance & Latency (Your low-latency tweaks) ---
      input_delay = 0;
      repaint_delay = 2;
      sync_to_monitor = "no";
      wayland_enable_ime = "no";

      # --- Visuals ---
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = lib.mkForce 12.0;
      window_padding_width = 25;
      cursor_trail = 1;
      enable_audio_bell = false;

      # --- Tab Bar ---
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # --- General ---
      kitty_mod = "alt";
    };
  };

  stylix.targets.kitty.enable = true;
}
