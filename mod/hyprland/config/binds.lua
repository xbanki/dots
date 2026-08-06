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
hl.bind(util.b("SUPER_L"), hl.dsp.exec_cmd("uwsm-app -- " .. config.SOFTWARE.LAUNCHER .. " -d"),
  { release = true, submap_universal = true, })

hl.bind(util.b("E"), hl.dsp.exec_cmd("uwsm-app -- " .. config.SOFTWARE.EXPLORER))
hl.bind(util.b("T"), hl.dsp.exec_cmd("uwsm-app -- " .. config.SOFTWARE.TERMINAL))

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

-- Shell state
hl.bind(util.b("L"), hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(util.b("ALT", "F2"), hl.dsp.exec_cmd("uwsm stop"))

-- Volume keys
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.1 @DEFAULT_AUDIO_SINK@ 2%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
  { locked = true, repeating = true })

-- Media keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
