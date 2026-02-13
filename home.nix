{ config, pkgs, ... }:

{
  imports = [
    ./modules/homeModules/base/shell.nix
    ./modules/homeModules/base/starship.nix
    ./modules/homeModules/base/bat.nix
    ./modules/homeModules/base/git.nix
    ./modules/homeModules/base/kitty.nix
    ./modules/homeModules/base/nixTools.nix
    ./modules/homeModules/base/yazi.nix
  ];

  home.username = "aryan";
  home.homeDirectory = "/home/aryan";
  home.stateVersion = "25.11";

  # This is the "Magic Fix" for Neovim LSPs on NixOS
  home.packages = with pkgs; [
    home-manager
    unzip
    gcc
    gnumake

    # Terminal Tools
    kitty
    neovim
    lsd
    fzf
    fastfetch
    wl-clipboard

    # Apps
    floorp-bin
    vlc
    localsend
    xfce.thunar
    zed-editor

    # Desktop
    waybar
    mako
    swaylock-effects
    fuzzel
    swww
    hyprpolkitagent

    # Themes
    adwaita-icon-theme
    gnome-themes-extra
    
    # Language Servers (LSPs)
    lua-language-server
    nil 
    pyright 
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    clang-tools
    tailwindcss-language-server
    jdt-language-server
    nodejs_22
  ];

  stylix.enableReleaseChecks = false;
  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;
}
