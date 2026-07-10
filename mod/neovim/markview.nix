# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  plugins.markview = {
    settings.preview = {
      icon_provider = "devicons";
      enable = false;
    };

    enable = true;
  };
}
