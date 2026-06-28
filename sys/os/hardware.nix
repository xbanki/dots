#   NixOS Hardware Configuration
#
# This file reflects the local hardware setup for my personal NixOS computer.
# For differing configurations, this file should be edited and updated to
# reflect the local machine.
#
# This file also implements any hardware specific drivers, namely Nvidia
# drivers.
#
#   Copyright: Banki <development@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  modulesPath,
  system,
  config,
  lib,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
    };

    graphics = {
      enable32Bit = true;
      enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/517d82fc-1c14-4a63-b7f6-29b75f33311d";
    }
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/2f111084-6aa7-403e-bdc9-b5a3c33a36ab";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7FA9-D626";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/cache" = {
      device = "/dev/disk/by-uuid/616a7c26-2c79-449f-a74d-68a16a15641b";
      fsType = "ext4";
    };

    "/share/ssd" = {
      device = "/dev/disk/by-uuid/18BA252054E697DE";
      fsType = "ntfs3";
      options = [
        "fmask=0133"
        "dmask=0022"
        "uid=1000"
        "gid=100"
        "nofail"
      ];
    };

    "/share/hdd" = {
      device = "/dev/disk/by-uuid/470C84C86E663F40";
      fsType = "ntfs3";
      options = [
        "dmask=0022"
        "fmask=0133"
        "uid=1000"
        "gid=100"
        "nofail"
      ];
    };
  };
}
