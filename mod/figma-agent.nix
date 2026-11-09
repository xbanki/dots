# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

let
  p = pkgs.extend (
    final: prev: {
      figma-agent = prev.figma-agent.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
        buildInputs = (old.buildInputs or [ ]) ++ [ final.zstd ];
      });
    }
  );
in
{
  home.packages = [
    p.figma-agent
  ];

  systemd.user.services.figma-agent = {
    Unit.Description = "Figma Font Agent";

    Service = {
      ExecStart = "${p.figma-agent}/bin/figma-agent";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
