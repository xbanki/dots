# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  modulesPath,
  system,
  config,
  props,
  lib,
  ...
}:

with props;
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/50f039aa-0f5d-41cf-a322-9e1a197f78d7";
      fsType = "ext4";
    };

    "/boot" = {
      options = [
        "fmask=0022"
        "dmask=0022"
      ];

      device = "/dev/disk/by-uuid/7FA9-D626";
      fsType = "vfat";
    };

    "/cache" = {
      device = "/dev/disk/by-uuid/885fd50f-a5d1-4bcb-978f-cbd1bf733f0a";
      fsType = "ext4";
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

      device = "/dev/disk/by-uuid/18BA252054E697DE";
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

      device = "/dev/disk/by-uuid/470C84C86E663F40";
      fsType = "ntfs3";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/517d82fc-1c14-4a63-b7f6-29b75f33311d"; }
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

  home-manager.users.${user.name}.xdg.cacheHome = "/cache/user/${user.name}";
  systemd = {
    user.settings.Manager.DefaultEnvironment = "XDG_CACHE_HOME=/cache/user/${user.name}";
    services.nix-daemon.environment.XDG_CACHE_HOME = "/cache";
    tmpfiles.rules = [
      "d /cache/nix 0755 root root -"
      "d /cache/user/${user.name} 0755 ${user.name} users -"
    ];
  };
}
