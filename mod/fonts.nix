# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

let
  options = [
    "ro"
    "x-gvfs-hide"
    "resolve-symlinks"
  ];

in
{
  fonts = {
    fontDir.enable = true;
    packages =
      with pkgs;
      let
        playfair = google-fonts.override { fonts = [ "PlayfairDisplay" ]; };
        cal-sans-text = mkCalSans {
          description = "Cal Sans Text, the typeface used for main bodies of text, by cal.com";
          pname = "cal-sans-text";
          pattern = "*Text*.ttf";
        };

        cal-sans-ui = mkCalSans {
          description = "Cal Sans UI, the interface typeface used by cal.com";
          pname = "cal-sans-ui";
          pattern = "*UI*.ttf";
        };

        mkCalSans =
          {
            pname,
            pattern,
            description,
          }:
          let
            version = "1.500";
            owner = "calcom";
            repo = "sans-ui";

          in
          stdenvNoCC.mkDerivation {
            inherit version pname;
            dontConfigure = true;
            dontBuild = true;
            src = fetchFromGitHub {
              inherit owner repo;
              hash = "sha256-H7PSLED3l9lx7TSbzN58hejorgSTEUxh0yolLU41WZ4=";
              rev = version;
            };

            installPhase = ''
              runHook preInstall
              mkdir -p $out/share/fonts/truetype/${pname}
              find . -iname '${pattern}' -exec cp {} $out/share/fonts/truetype/${pname}/ \;
              runHook postInstall
            '';

            meta = with lib; {
              inherit description;
              homepage = "https://github.com/${owner}/${repo}";
              platforms = platforms.all;
              license = licenses.ofl;
            };

          };

      in
      [
        nerd-fonts.symbols-only
        noto-fonts-color-emoji
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        jetbrains-mono
        cal-sans-text
        cal-sans-ui
        noto-fonts
        ibm-plex
        playfair
      ];

    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [
          "IBM Plex Mono"
          "Noto Sans Mono"
          "Noto Sans CJK JP"
          "Noto Color Emoji"
          "Symbols Nerd Font Mono"
        ];

        sansSerif = [
          "Cal Sans Text"
          "Noto Sans"
          "Noto Sans CJK JP"
          "Noto Color Emoji"
          "Symbols Nerd Font"
        ];

        serif = [
          "Playfair Display"
          "Noto Serif"
          "Noto Serif CJK JP"
          "Noto Color Emoji"
          "Symbols Nerd Font"
        ];

        emoji = [
          "Noto Color Emoji"
          "Symbols Nerd Font"
        ];
      };
    };
  };

  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = {
    "/usr/share/themes" = {
      inherit options;
      device = "/run/current-system/sw/share/themes";
      fsType = "fuse.bindfs";
    };

    "/usr/share/fonts" = {
      inherit options;
      device = "/run/current-system/sw/share/X11/fonts";
      fsType = "fuse.bindfs";
    };

    "/usr/share/icons" = {
      inherit options;
      device = "/run/current-system/sw/share/icons";
      fsType = "fuse.bindfs";
    };
  };
}
