{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.git.override { withLibsecret = true; };

    # All these were moved inside 'settings'
    settings = {
      user = {
        name = "Aryan";
        email = "146753457+7H3-4RY4N@users.noreply.github.com"; 
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "desktop.ini"
    ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; 
    
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
