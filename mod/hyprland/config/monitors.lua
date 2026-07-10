-- Copyright: Banki <development@xbanki.me>
--            Licensed under the MIT License.
--            See LICENSE for details.

local config = require "config"

local M = {}

-- The description of the current primary monitor.
--
---@type nil|string
M.primary_monitor_descriptor = nil

-- The connector, or the port where the primary monitor is connected.
--
---@type nil|string
M.primary_monitor_connector = nil

-- The "canonical" separator for workspace names.
--
---@type string
M.canonical_separator = "_"

-- The canonical name for the primary workspace.
--
---@type string
M.canonical_primary = "primary"

-- Cached original workspace for hidden windows.
--
---@type table<string, table<string, string>>
M.windows_hidden = {}

-- Cached hide order of windows per workspace.
--
---@type table<string, string[]>
M.windows_hidden_order = {}

-- Concatenates a variable list of `string` values into one contiguous value, in lowercase.
--
---@param ... string Variable list which to concatenate.
---@return    string
local function merge_segments(...)
  return table.concat({ ... }):lower()
end

-- Generates a canonical workspace identifier for named workspaces. Accounts for the possibility of variable workspace
-- naming, by providing a `other` parameter that can be of any type, that is then dynamically stringified upon use.
--
---@param name  string The actual name of the workspace. Typically is `monitor.name` (The connector name).
---@param other any    Any extra data, that will be appended to the canoncial identifier.
---@return      string
local function canonicalize(name, other)
  local prefix = "name:"
  if other ~= nil then
    return merge_segments(prefix, name, M.canonical_separator, type(other) ~= "string" and tostring(other) or other)
  else
    return merge_segments(prefix, name)
  end
end

-- Same as `canonicalize`, except returns a special workspace identifier that is meant to be used for a monitor's
-- `hidden` workspace.
--
---@param  name string Hidden workspace name. Typically references `monitor.name`.
---@return      string
local function canonicalize_hidden(name)
  local marker = "hidden"
  return merge_segments(marker, M.canonical_separator, name)
end


-- Same as `canonicalize_hidden`, with the exception of a `special` workspace prefix. Useful for identifier selectors.
--
---@param  name string Workspace name. Typically refers to `monitor.name`.
---@return      string
local function canonicalize_hidden_prefixed(name)
  local prefix = "special:"
  local marker = "hidden"
  return merge_segments(prefix, marker, M.canonical_separator, name)
end

-- Enumerates all connected monitor, before assigning a "primary" monitor. The primary monitor is then responsible for
-- displaying "primary" monitor responsibilities, such as X-server notifications.
--
-- The primary monitor is selected preferentially. That is to say that, if the "Preferred" primary monitor is connected,
-- it is automatically selected as the primary. In other cases, the rightmost monitor is selected as the primary.
function M.enumerate_primary()
  local monitors = hl.get_monitors()
  table.sort(monitors, function(a, b)
    if type(a.position) ~= "table" or type(b.position) ~= "table" then
      return false
    end

    return a.position.x < b.position.x
  end)

  for _, monitor in ipairs(monitors) do
    if monitor.description == config.MONITOR_PRIMARY then
      M.primary_monitor_descriptor = monitor.description
      M.primary_monitor_connector = monitor.name
    end
  end

  if M.primary_monitor_descriptor == nil then
    local monitor = monitors[#monitors]
    M.primary_monitor_descriptor = monitor.description
    M.primary_monitor_connector = monitor.name
  end
end

-- Collapses both orphaned and unmanaged workspaces into our managed, existing workspaces that facilitate content on
-- connected monitors. These "unmanaged" workspaces are divided into two buckets based on the following criteria:
--
--  1. Unmanaged — Workspaces that do not conform to the "spec" (Naming scheme) of our managed workspaces. These are
--                 automatically collapsed into the primary workspace of the monitor they appear on.
--  2. Orphaned  — Workspaces that do conform to our naming scheme, but no longer have their parent monitor attached.
--
-- In the case that the primary workspace becomes orphaned, it is simply ignored and moved.
function M.collapse_workspaces()
  local workspaces_unmanaged = {}
  local workspaces_orphaned = {}
  local monitor_connectors = {}
  for _, monitor in ipairs(hl.get_monitors()) do
    monitor_connectors[monitor.name] = true
  end

  for _, workspace in ipairs(hl.get_workspaces()) do
    if workspace.name ~= M.canonical_primary
        and workspace.name ~= canonicalize_hidden_prefixed(workspace.monitor.name)
        and not workspace.is_empty then
      if monitor_connectors[workspace.monitor.name] ~= nil then
        local name = workspace.monitor.name:lower()
        if workspace.name:sub(1, #name + 1) ~= name .. "_" or workspace.name:match("[2-9]$") == nil then
          table.insert(workspaces_unmanaged, workspace)
        end
      else
        table.insert(workspaces_orphaned, workspace)
      end
    end
  end

  for _, workspace in ipairs(workspaces_unmanaged) do
    for _, window in ipairs(hl.get_workspace_windows(workspace.name)) do
      if workspace.monitor.description ~= M.primary_monitor_descriptor then
        hl.dispatch(hl.dsp.window.move({
          workspace = canonicalize(workspace.monitor.name, 2),
          window = "address:" .. window.address,
          follow = false,
        }))
      else
        hl.dispatch(hl.dsp.window.move({
          workspace = canonicalize(M.canonical_primary),
          window = "address:" .. window.address,
          follow = false,
        }))
      end
    end
  end

  for _, workspace in ipairs(workspaces_orphaned) do
    print("TODO: Handle orphaned workspace:", workspace.name, workspace.monitor.description)
  end
end

-- Activates the created workspaces, so that they can then be used by windows, before activating the legacy X-server
-- "primary" monitor setting.
--
-- *NOTE*: If there are unmanaged workspaces active, they will lose focus immediately as the function is called.
function M.activate_workspaces()
  local last_active_window = hl.get_active_window()
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.description ~= M.primary_monitor_descriptor then
      hl.dispatch(hl.dsp.focus({ workspace = canonicalize(monitor.name, 2) }))
    else
      hl.dispatch(hl.dsp.focus({ workspace = canonicalize(M.canonical_primary), }))
    end
  end

  hl.dispatch(hl.dsp.exec_cmd("xrandr --output " .. M.primary_monitor_connector .. " --primary"))
  if last_active_window ~= nil then
    hl.dispatch(hl.dsp.focus({ window = "address:" .. last_active_window.address, }))
  else
    hl.dispatch(hl.dsp.focus({ workspace = canonicalize(M.canonical_primary), }))
  end
end

-- Initializes all necessary workspaces for each of the connected monitors. These workspaces are:
--
--  1. The "Primary" workspace;
--  2. Secondary workspaces (2-9);
--  3. Hidden windows workspace;
function M.set_workspaces()
  for _, monitor in ipairs(hl.get_monitors()) do
    if M.windows_hidden[monitor.name] == nil then
      M.windows_hidden[monitor.name] = {}
    end

    if M.windows_hidden_order[monitor.name] == nil then
      M.windows_hidden_order[monitor.name] = {}
    end

    local bind_default = false
    if monitor.name ~= M.primary_monitor_connector then
      bind_default = true
    else
      hl.workspace_rule({
        workspace = canonicalize(M.canonical_primary),
        monitor = monitor.name,
        persistent = true,
        default = true,
      })
    end

    for idx = 2, 9 do
      hl.workspace_rule({
        workspace = canonicalize(monitor.name, idx),
        default = bind_default,
        monitor = monitor.name,
      })
    end

    hl.workspace_rule({
      workspace = canonicalize_hidden_prefixed(monitor.name),
      monitor = monitor.name,
      persistent = true,
      default = false,
    })
  end
end

-- Creates a Hyprland keybind function for switching between the workspaces on the current monitor. The workspace
-- selected depends on the bind: If `index == 1`, the primary workspace is slected. Otherwise, the monitor specific
-- workspace is selected.
--
---@param index integer The "index" of the monitor workspace to focus.
function M.bind_workspace_switch(index)
  return function()
    if index ~= 1 and index <= 9 then
      local monitor = hl.get_active_monitor()
      if monitor ~= nil then
        hl.dispatch(hl.dsp.focus({ workspace = canonicalize(monitor.name, index), }))
      end
    else
      hl.dispatch(hl.dsp.focus({ workspace = canonicalize(M.canonical_primary), }))
    end
  end
end

-- Creates a Hyprland keybind function for switching to the monitor's hidden workspace. This workspace appears over the
-- top of the monitor's active workspace, as all special Hyprland workspaces do.
function M.bind_workspace_hidden()
  return function()
    local monitor = hl.get_active_monitor()
    if monitor ~= nil then
      hl.dispatch(hl.dsp.workspace.toggle_special(canonicalize_hidden(monitor.name)))
    end
  end
end

-- Creates a Hyprland keybind function for hiding and unhiding windows inside a monitor context. Windows are
-- automatically sent to their original workspace upon unhide, unless the workspace cannot be found.
function M.bind_window_hide()
  return function()
    local window = hl.get_active_window()
    if window ~= nil then
      local hide_workspace_name = canonicalize_hidden_prefixed(window.monitor.name)
      if window.workspace.name ~= hide_workspace_name then
        M.windows_hidden[window.monitor.name][window.address] = window.workspace.name
        table.insert(M.windows_hidden_order[window.monitor.name], window.address)
        hl.dispatch(hl.dsp.window.move({
          workspace = canonicalize_hidden_prefixed(window.monitor.name),
          window = "address:" .. window.address,
          follow = false,
        }))
      else
        local unhide_workspace_name = M.windows_hidden[window.monitor.name][window.address]
        if unhide_workspace_name ~= nil then
          unhide_workspace_name = canonicalize(unhide_workspace_name)
        elseif window.monitor.description ~= M.primary_monitor_descriptor then
          unhide_workspace_name = canonicalize(window.monitor.name, 2)
        else
          unhide_workspace_name = canonicalize(M.canonical_primary)
        end

        hl.dispatch(hl.dsp.window.move({
          window = "address:" .. window.address,
          workspace = unhide_workspace_name,
          follow = false,
        }))
        M.windows_hidden[window.monitor.name][window.address] = nil
      end
    end
  end
end

-- Creates a Hyprland keybind function that unhides the last hidden window within a monitor context. The bind tries to
-- send the window to it's original source, unless the originating workspace cannot be found, at which point the window
-- is just sent to the monitor's primary workspace.
function M.bind_window_unhide_last()
  return function()
    local monitor = hl.get_active_monitor()
    if monitor ~= nil and #M.windows_hidden_order[monitor.name] > 0 then
      while #M.windows_hidden_order[monitor.name] > 0 do
        local address = table.remove(M.windows_hidden_order[monitor.name])
        local workspace = hl.get_workspace(canonicalize_hidden_prefixed(monitor.name))
        if workspace ~= nil then
          local found = false
          for _, window in ipairs(hl.get_workspace_windows(workspace.name)) do
            if window.address == address then
              found = true
              break
            end
          end

          if found then
            local unhide_workspace_name = M.windows_hidden[monitor.name][address]
            if unhide_workspace_name ~= nil then
              unhide_workspace_name = canonicalize(unhide_workspace_name)
            elseif monitor.description ~= M.primary_monitor_descriptor then
              unhide_workspace_name = canonicalize(monitor.name, 2)
            else
              unhide_workspace_name = canonicalize(M.canonical_primary)
            end
            hl.dispatch(hl.dsp.window.move({
              workspace = unhide_workspace_name,
              window = "address:" .. address,
              follow = true,
            }))
            M.windows_hidden[monitor.name][address] = nil
            break
          end
        else
          break
        end
      end
    end
  end
end

-- Creates a Hyprland keybind function that switches the currently focused workspace within the monitor context, with
-- the exception of the "primary" workspace which is always bound to the first index (`1`).
--
---@param index integer The workspace index which to bind to.
function M.bind_window_move(index)
  return function()
    if index ~= 1 and index <= 9 then
      local monitor = hl.get_active_monitor()
      if monitor ~= nil then
        hl.dispatch(hl.dsp.window.move({ workspace = canonicalize(monitor.name, index), follow = false, }))
      end
    else
      hl.dispatch(hl.dsp.window.move({ workspace = canonicalize(M.canonical_primary), follow = false, }))
    end
  end
end

return M
