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
      device = "/dev/disk/by-uuid/84edaebd-8060-4f1c-9402-8f766a2b4333";
      fsType = "ext4";
    };

    "/boot" = {
      options = [
        "fmask=0022"
        "dmask=0022"
      ];

      device = "/dev/disk/by-uuid/DD19-4ED5";
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

      device = "/dev/disk/by-uuid/7DB4BC244C6D9A95";
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

      device = "/dev/disk/by-uuid/5ECBA2F0307D0A5F";
      fsType = "ntfs3";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/638bc83e-2c4d-481f-988a-b7f46306c4ad"; }
  ];

  powerManagement.cpuFreqGovernor = "performance";
  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault system;
  services.xserver.videoDrivers = [ "nvidia" ];
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  hardware = {
    wooting.enable = true;
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
