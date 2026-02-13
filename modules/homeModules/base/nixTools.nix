{ pkgs, ... }: {
  programs = {
    # 1. NH: The better way to rebuild and clean your system
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
      flake = "/home/aryan/nixdots"; # Point to YOUR dots
    };

    # 2. Direnv: Auto-load project environments
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # 3. Television: Fuzzy finder for your shell
    television = {
      enable = true;
      # This allows Television to work with Zsh (your shell)
      enableZshIntegration = true; 
    };

    # 4. Nix Search: Find packages fast
    nix-init.enable = true;
  };

  home.packages = with pkgs; [
    nix-search-tv
    ripgrep # Required for fast searching
    fd      # Required for finding files
  ];
}
