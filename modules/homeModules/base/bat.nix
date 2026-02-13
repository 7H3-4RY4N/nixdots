{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
    ];
  };

  # This makes 'man' pages look beautiful in Zsh
  programs.zsh.initContent = ''
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    alias man="batman"
  '';
}
