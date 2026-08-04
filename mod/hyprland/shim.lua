-- harper: ignore
-- luacheck: globals hl
---@diagnostic disable

--- Copyright: Banki <development@xbanki.me>
---            Licensed under the MIT License.
---            See LICENSE for details.

-- Additionally, we also clear any Hyprland notifications that may have been
-- created when plugins get loaded.
hl.exec_cmd("hyprctl dismissnotify")

require "env"
require "binds"
require "rules"

local config = require "config"
local monitors = require "monitors"

hl.on("hyprland.start", function()
  hl.exec_cmd("nix-shell -p setxkbmap --run \"setxkbmap " .. config.KEYBOARD.LAYOUT .. "\"")
end)

local function callback_monitors()
  monitors.enumerate_primary()
  monitors.set_workspaces()
  monitors.collapse_workspaces()
  monitors.activate_workspaces()
end

hl.on("hyprland.start", callback_monitors)
hl.on("config.reloaded", callback_monitors)
hl.on("monitor.added", callback_monitors)
hl.on("monitor.removed", callback_monitors)

local config_dir = os.getenv("XDG_CONFIG_HOME")
if config_dir ~= nil then
  local sep = package.config:sub(1, 1)
  local file = io.open(config_dir .. sep .. "hypr" .. sep .. "devel.lua")
  if file ~= nil then
    file:close()
    hl.config({
      misc = {
        disable_autoreload = false,
      },

      debug = {
        enable_stdout_logs = true,
        disable_logs = false,
      },
    })

    require "devel"
  end
end
