# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, ... }:

with props;
{
  programs.nixcord = {
    config.plugins = {
      fakeNitro = {
        enableStickerBypass = false;
        enableEmojiBypass = false;
        enable = true;
      };

      ignoreActivities = {
        idsList = "357606832899883008";
        enable = true;
        listMode = 1;
      };

      accountPanelServerProfile.enable = true;
      webScreenShareFixes.enable = true;
      alwaysExpandRoles.enable = true;
      disableDeepLinks.enable = true;
      webContextMenus.enable = true;
      alwaysAnimate.enable = true;
      crashHandler.enable = true;
      webKeybinds.enable = true;
      hideMedia.enable = true;
      noF1.enable = true;
    };

    vesktop.enable = true;
    user = user.name;
    enable = true;
  };
}
