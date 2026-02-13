{ inputs, pkgs, ... }: {
  imports = [
    # 1. Hardware and Base
    ./hardware-configuration.nix
    ../../base/nix.nix
    ../../base/users.nix
    ../../base/locale.nix
    ../../base/stylix.nix

    # 2. Features (Compositor and Login)
    ../../features/niri.nix
    ../../features/greeter.nix
  ];

  # --- HOST IDENTITY ---
  # This sets the network name for this specific machine.
  networking.hostName = "nitrochan";

  # --- BOOT & KERNEL ---
  # systemd-boot: Modern UEFI bootloader.
  # kernelParams: Fixes for your specific backlight and ACPI issues.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];
  boot.kernelParams = [
    "acpi_backlight=native"
    "acpi_osi=Linux"
    "acpi_enforce_rsources=lax"
  ];

  # --- HARDWARE SERVICES ---
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.i2c.enable = true;
  services.gvfs.enable = true; # Needed for mounting drives/phones in Thunar

  # --- SYSTEM PACKAGES ---
  # These are available to all users. 
  # We moved Zsh and Niri specifics out, keeping general tools here.
  environment.systemPackages = with pkgs; [
    brightnessctl # Screen brightness control
    playerctl     # Media (play/pause) control
    git           # Version control
    blueman       # Bluetooth manager GUI
    libmtp        # Phone connection support
    powertop      # Battery usage analysis
    i2c-tools     # Hardware debugging
    usbutils      # lsusb command
    piper         # Mouse config GUI
    libratbag     # Mouse config driver
  ];

  # --- FONTS ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # --- PROGRAMS & SECURITY ---
  # Thunar: File manager with plugins for archives and volumes.
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin 
    ];
  };

  # SSH: Starts the ssh-agent for key management.
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  # Android & Misc
  programs.adb.enable = true;
  security.polkit.enable = true;

  # --- FIREWALL ---
  # Opens port 53317 for LocalSend (TCP/UDP).
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  # --- HOME MANAGER ---
  # This links your human user 'aryan' to the home.nix config.
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.aryan = import ../../../../home.nix;
  };

  # --- VERSIONING ---
  # This must stay the same as when you first installed.
  system.stateVersion = "25.11"; 
}
