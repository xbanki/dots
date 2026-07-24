# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        extraGrubInstallArgs = [
          "--disable-shim-lock"
          "--modules=tpm"
        ];

        extraEntriesBeforeNixOS = true;
        extraEntries = ''
          menuentry "EFI System Settings" {
            fwsetup
          }
        '';

        extraConfig = "GRUB_SAVEDEFAULT=true";
        configurationName = "Nix";
        configurationLimit = 16;
        efiSupport = true;
        default = "saved";
        device = "nodev";
        enable = true;
      };
    };
  };
}
