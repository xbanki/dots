-- Copyright: Banki <development@xbanki.me>
--            Licensed under the MIT License.
--            See LICENSE for details.

local config = require "config"

-- Environment variables
hl.env("XDG_CACHE_HOME", "/cache/user/" .. config.USERNAME)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Force Wayland session everywhere
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Nvidia driver variables
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("WLR_DRM_NO_ATOMIC", "1")

-- Global configuration
hl.config({

  -- Disable default background in favor of our own.
  misc = {
    disable_splash_rendering = true,
    disable_hyprland_logo = true,
    middle_click_paste = false,
  },

  -- Popups.
  ecosystem = {
    no_donation_nag = true,
    no_update_news = true,
  },

  -- Enable tearing for performance reasons.
  general = {
    extend_border_grab_area = 18,
    resize_on_border = true,
    allow_tearing = true,
  },

  -- Mouse & keyboard.
  input = {
    accel_profile = config.MOUSE.ACCELERATION_PROFILE,
    sensitivity = config.MOUSE.SENSITIVITY,
    kb_options = config.KEYBOARD.OPTIONS,
    kb_variant = config.KEYBOARD.VARIANT,
    kb_layout = config.KEYBOARD.LAYOUT,
  },

  -- XWayland
  xwayland = {
    force_zero_scaling = true,
  },
})

-- Monitors.
hl.monitor({
  output = "desc:BNQ BenQ GW2470 K9H02321SL0",
  mode = "preferred",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "desc:Lenovo Group Limited R25f-30 URW12Z0R",
  position = "1920x0",
  mode = "preferred",
  scale = 1,
})

-- Hyprbars functionality
if hl.plugin.hyprbars ~= nil then
  hl.config({
    plugin = {
      hyprbars = {
        on_double_click = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\", })'",
      },
    },
  })
end

-- Gaming rules.
if hl.plugin.csgo_vulkan_fix ~= nil then
  hl.config({
    plugin = {
      csgo_vulkan_fix = {
        fix_mouse = true,
      },
    },
  })

  hl.plugin.csgo_vulkan_fix.vkfix_app({ app = "cs2", w = 1440, h = 1080, })
end

hl.window_rule({
  name = "tearing-steam",
  match = { class = "^(steam_app_.*)$", },
  workspace = "name:primary",
  immediate = true,
})

hl.window_rule({
  name = "tearing-proton",
  match = { title = ".*\\.exe$", },
  workspace = "name:primary",
  immediate = true,
})

hl.window_rule({
  name = "tearing-gamescope",
  match = { class = "^(gamescope)$", },
  workspace = "name:primary",
  immediate = true,
})
