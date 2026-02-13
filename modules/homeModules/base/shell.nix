{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # History Settings
    history = {
      size = 1000000;
      save = 1000000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      share = true;
    };

    # Aliases
    shellAliases = {
      ls = "lsd";
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      tree = "lt";
      ff = "fastfetch";
      vim = "nvim";
      vi = "nvim";
      ".." = "cd ..";
      # Our new favorite command
      nrs = "sudo nixos-rebuild switch --flake ~/nixdots#nitrochan";
    };

    # Keybinds & Custom Logic (initExtra)
    initContent = ''
      # Keybinds
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      
      # Zinit Setup (Nix doesn't manage Zinit, so we keep your manual setup)
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      source "''${ZINIT_HOME}/zinit.zsh"

      # Plugins via Zinit
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light Aloxaf/fzf-tab
      zinit snippet OMZP::command-not-found
    '';
  };

  # These replacements handle the "eval" lines from your old config automatically
  programs.starship.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
