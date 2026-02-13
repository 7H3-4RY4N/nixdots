{ lib, config, ... }:
let
  # Direct access to Stylix hex colors
  c = config.lib.stylix.colors;
  
  # Color definitions for the Powerline segments
  bg_dark = "#${c.base02}"; # Grayish/Dark
  orange  = "#${c.base09}";
  green   = "#${c.base0B}";
  aqua    = "#${c.base0C}";
  blue    = "#${c.base0D}";
  purple  = "#${c.base0E}";
  text    = "#${c.base05}"; # Primary text color
  bg_root = "#${c.base00}"; # Terminal background color
in
{
  # Disable Stylix's default starship target to prevent conflicts
  stylix.targets.starship.enable = false;

  programs.starship = {
    enable = true;
    settings = lib.mkForce {
      "$schema" = "https://starship.rs/config-schema.json";

      # Assemble the format using the hex variables defined above
      format = lib.concatStrings [
        "[](${bg_dark})"
        "$os"
        "$username"
        "[](bg:${orange} fg:${bg_dark})"
        "$directory"
        "[](fg:${orange} bg:${green})"
        "$git_branch"
        "$git_status"
        "[](fg:${green} bg:${aqua})"
        "$c"
        "$cpp"
        "$rust"
        "$golang"
        "$nodejs"
        "$python"
        "[](fg:${aqua} bg:${blue})"
        "$docker_context"
        "[](fg:${blue} bg:${purple})"
        "$time"
        "[ ](fg:${purple})"
        "$line_break$character"
      ];

      os = {
        disabled = false;
        style = "bg:${bg_dark} fg:${text}";
        symbols.NixOS = " ";
      };

      username = {
        show_always = true;
        style_user = "bg:${bg_dark} fg:${text}";
        style_root = "bg:${bg_dark} fg:${text}";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:${bg_root} bg:${orange}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:${green}";
        format = "[[ $symbol $branch ](fg:${bg_root} bg:${green})]($style)";
      };

      git_status = {
        style = "bg:${green}";
        format = "[[($all_status$ahead_behind )](fg:${bg_root} bg:${green})]($style)";
        # Git status symbols
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };

      # Programming Language Modules (All share the Aqua background)
      c = {
        symbol = " ";
        style = "bg:${aqua}";
        format = "[[ $symbol( $version) ](fg:${bg_root} bg:${aqua})]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:${aqua}";
        format = "[[ $symbol( $version) ](fg:${bg_root} bg:${aqua})]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:${aqua}";
        format = "[[ $symbol( $version) ](fg:${bg_root} bg:${aqua})]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:${aqua}";
        format = "[[ $symbol( $version) ](fg:${bg_root} bg:${aqua})]($style)";
      };

      python = {
        symbol = " ";
        style = "bg:${aqua}";
        format = "[[ $symbol( $version) ](fg:${bg_root} bg:${aqua})]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:${blue}";
        format = "[[ $symbol( $context) ](fg:${bg_root} bg:${blue})]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:${purple}";
        format = "[[  $time ](fg:${bg_root} bg:${purple})]($style)";
      };

      character = {
        success_symbol = "[](bold ${green})";
        error_symbol = "[](bold #${c.base08})"; # Base08 is Red
        vimcmd_symbol = "[](bold ${green})";
      };

      line_break.disabled = false;
    };
  };
}
