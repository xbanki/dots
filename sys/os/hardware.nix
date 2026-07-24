# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

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

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4ff24e58-c219-4984-99fa-a8c853c9a277";
      fsType = "ext4";
    };

    "/boot" = {
      options = [
        "fmask=0022"
        "dmask=0022"
      ];

      device = "/dev/disk/by-uuid/1AF2-81C6";
      fsType = "vfat";
    };

    "/share/ssd" = {
      options = [
        "uid=1000"
        "gid=1000"
        "rw"
        "user"
        "exec"
        "umask=000"
      ];

      device = "/dev/disk/by-uuid/8C0244B00244A156";
      fsType = "ntfs3";
    };

    "/share/hdd" = {
      options = [
        "uid=1000"
        "gid=1000"
        "rw"
        "user"
        "exec"
        "umask=000"
      ];

      device = "/dev/disk/by-uuid/4840454F40454542";
      fsType = "ntfs3";
    };

    "/share/media" = {
      options = [
        "uid=1000"
        "gid=1000"
        "rw"
        "user"
        "exec"
        "umask=000"
      ];

      device = "/dev/disk/by-uuid/7CC6671EC666D7C2";
      fsType = "ntfs3";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/63d63beb-4c11-42ef-8751-f5014f572530"; }
  ];

  powerManagement.cpuFreqGovernor = "performance";
  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault system;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    steam-hardware.enable = true;
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
}
