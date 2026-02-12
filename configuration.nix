{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];

  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;

  #Experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aryan = {
    isNormalUser = true;
    description = "aryan";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "i2c" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  boot.kernelParams = [
   "acpi_backlight=native"
   "acpi_osi=Linux"
   "acpi_enforce_rsources=lax"
];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
	

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ]; 
      serif     = [ "JetBrainsMono Nerd Font" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim    
    kitty
    waybar
    mako
    wl-clipboard
    brightnessctl 
    git
    zsh
    starship
    lsd
    zoxide
    fzf
    fastfetch
    swaylock-effects
    neovim
    firefox
    fuzzel
    blueman
    xfce.thunar
    adwaita-icon-theme
    gnome-themes-extra
    vlc
    floorp-bin
    yazi
    swww
    libmtp
    gvfs
    hyprpolkitagent
    powertop
    localsend
    zed-editor
    i2c-tools
    usbutils
    pkgs.piper
    libratbag
  ];

environment.variables = {
  GTK_THEME = "Adwaita-dark";
};

programs.dconf.enable = true;
programs.dconf.profiles.user.databases = [{
  settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}];

#Thunar
programs.thunar = {
  enable = true;
  plugins = with pkgs.xfce; [
    thunar-volman
    thunar-archive-plugin 
  ];
};

#LocalSend Port allow
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 53317 ];
  allowedUDPPorts = [ 53317 ];
};

#Garbage Collection
nix = {
  settings.auto-optimise-store = true; 
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; 
  };
};
  
  services.gnome.gcr-ssh-agent.enable = false;

  programs.ssh.startAgent = true;
  hardware.i2c.enable = true;
  programs.niri.enable = true;
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  services.gvfs.enable = true;
  programs.adb.enable = true;
  security.polkit.enable = true;

#Greetd
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };
};

systemd.services.greetd.serviceConfig = {
  Type = "idle";
  StandardInput = "tty";
  StandardOutput = "tty";
  StandardError = "journal";
  TTYReset = true;
  TTYVHangup = true;
  TTYVTDisallocate = true;
};

#ZSH
programs.zsh = {
  enable = true;
  enableGlobalCompInit = false; 
};

  system.stateVersion = "25.11"; # Did you read the comment?

}
