# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  services.pipewire = {
    alsa = {
      support32Bit = true;
      enable = true;
    };

    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    enable = true;
  };
}
