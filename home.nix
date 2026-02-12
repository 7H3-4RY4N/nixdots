{ pkgs, ... }:

{
  home.username = "aryan";
  home.homeDirectory = "/home/aryan";
  home.stateVersion = "25.11";

  # This is the "Magic Fix" for Neovim LSPs on NixOS
  home.packages = with pkgs; [
    home-manager
    # General Tools
    unzip
    gcc
    gnumake
    
    # Language Servers (LSPs)
    lua-language-server
    nil # Nix LSP
    pyright # Python
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    clang-tools
    tailwindcss-language-server
    jdt-language-server
  ];

  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;
}
