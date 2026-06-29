#   NixOS Boot Manager
#
# We use GRUB as our boot manager, which forces us to manually sign all
# bootloader files whenever the configuration is rebuilt.
#
#   Copyright: Banki <development@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:
let
  efi_uuid = "7FA9-D626";

in
{
  system.activationScripts.secureBootSign = {
    deps = [ "specialfs" ];
    text = ''
      set -euo pipefail
      ${lib.getExe pkgs.sbctl} verify --json \
        | ${lib.getExe pkgs.jq} -r '
          .[]
          | select(.is_signed == 0)
          | select(.file_name | test("microsoft"; "i") | not)
          | .file_name
        ' \
        | while IFS= read -r file; do
            ${pkgs.sbctl}/bin/sbctl sign -s "$file"
          done
    '';
  };

  boot = {
    initrd.availableKernelModules = [
      "usb_storage"
      "xhci_pci"
      "usbhid"
      "sd_mod"
      "nvme"
      "ahci"
    ];

    kernelParams = [
      "loglevel=3"
      "quiet"
    ];

    loader = {
      grub = {
        extraGrubInstallArgs = [
          "--disable-shim-lock"
          "--modules=tpm"
        ];
        extraEntries = ''
          menuentry 'Windows 11' --class windows {
            savedefault
            insmod part_gpt
            insmod chain
            insmod ntfs
            insmod fat
            search --no-floppy --fs-uuid --set=root ${efi_uuid}
          }
        '';

        extraConfig = ''
          GRUB_SAVEDEFAULT=true
        '';

        configurationName = "Nix";
        configurationLimit = 1;
        efiSupport = true;
        default = "saved";
        device = "nodev";
        enable = true;
      };

      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs" ];
    kernelModules = [ "kvm-amd" ];
  };
}
