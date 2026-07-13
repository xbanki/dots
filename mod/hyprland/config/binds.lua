-- Copyright: Banki <development@xbanki.me>
--            Licensed under the MIT License.
--            See LICENSE for details.

local monitors = require "monitors"
local config = require "config"
local util = require "util"

-- Workspace binding.
for i = 1, 9 do
  hl.bind(util.b("SHIFT", tostring(i)), monitors.bind_window_move(i))
  hl.bind(util.b(tostring(i)), monitors.bind_workspace_switch(i))
end

-- Hide window functionality.
hl.bind(util.b("SHIFT", "H"), monitors.bind_window_unhide_last())
hl.bind(util.b("ALT", "H"), monitors.bind_workspace_hidden())
hl.bind(util.b("H"), monitors.bind_window_hide())

-- Window management.
hl.bind(util.b("Return"), hl.dsp.window.fullscreen_state({ internal = 3, client = -1, action = "toggle", }))
hl.bind(util.b("mouse:272"), hl.dsp.window.drag(), { mouse = true, })
hl.bind(util.b("W"), hl.dsp.window.close())
hl.bind(util.b("Q"), hl.dsp.window.kill())

-- Software launch.
hl.bind(util.b("SUPER_L"), hl.dsp.exec_cmd(config.SOFTWARE.LAUNCHER), { release = true, submap_universal = true, })
hl.bind(util.b("E"), hl.dsp.exec_cmd(config.SOFTWARE.EXPLORER))
hl.bind(util.b("T"), hl.dsp.exec_cmd(config.SOFTWARE.TERMINAL))

-- Screenshot.
hl.bind("print",
  hl.dsp.exec_cmd(
    'OUTPUT=$(xdg-user-dir PICTURES)/Screenshots;     \
     mkdir -p \"$OUTPUT\";                            \
     grim -g \"$(slurp -d)\" - |                      \
     tee \"$OUTPUT/$(date +%Y-%m-%d_%H-%M-%S).png\" | \
     wl-copy'
  )
)

-- Hyprland exit.
hl.bind(util.b("ALT", "F2"), hl.dsp.exit())
