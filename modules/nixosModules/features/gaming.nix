{ config, pkgs, ... }: {
  # 1. Hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    finegrained = true;
  };

  # 2. NVIDIA Driver Config
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; 
    open = false; # Set to true if you want to try the open-source kernel modules
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Adjusted for your specific hardware
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:116:0:0"; 
    };
  };

  # 3. Gaming Tools
  environment.systemPackages = with pkgs; [
    heroic
    mangohud
    gamemode
    protonup-qt
  ];
}
