# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "suspend-inhibited" ''
      #!/bin/bash
      set -euo pipefail
      statefile=/var/lib/hypridle/inhibit-suspend
      if [ -f "$statefile" ]; then
        case "$(cat "$statefile")" in
          0) exit 0 ;;
          *) exit 1 ;;
        esac
      fi

      exit 0
    '')
  ];

  systemd.tmpfiles.rules = [
    "d /var/lib/hypridle 0755 root root -"
    "f /var/lib/hypridle/inhibit-suspend 0666 root root - 0"
  ];
}
