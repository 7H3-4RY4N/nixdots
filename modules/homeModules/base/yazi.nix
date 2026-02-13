{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    # Allows Yazi to handle almost any compressed file format
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
    
    enableZshIntegration = true; 
    shellWrapperName = "y"; # Type 'y' to launch

    settings = {
      manager = {
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        max_width = 1000;
        max_height = 1000;
      };
    };
  };
}
