-- Copyright: Banki <development@xbanki.me>
--            Licensed under the MIT License.
--            See LICENSE for details.

local M = {}

M.SUPER_KEY = "SUPER"

-- Concatenates a variable number of "segments" into a single Hyprland keybind.
--
---@param  ... any    Any type segment, that must resolve to a string.
---@return     string
function M.b(...)
  local sep = " + "
  return M.SUPER_KEY .. sep .. table.concat({ ... }, sep)
end

return M
