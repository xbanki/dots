# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  plugins.indent-blankline = {
    settings = {
      scope.enabled = false;
      indent.char = "▏";
    };

    enable = true;
  };
}
