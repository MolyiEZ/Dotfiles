local wezterm = require('wezterm')
local util = require('tabline.util')
local mode = 'NORMAL'

local M = {}

function M.update(window)
  if window:leader_is_active() then
    return util.constant_width(mode .. '  ', wezterm.nerdfonts.oct_rocket)
  else
    mode = util.constant_width(mode, M.get(window):gsub('_mode', ''))
    mode = mode:upper()
    return mode
  end
end

function M.get(window)
  local key_table = window:active_key_table()

  if key_table == nil or not key_table:find('_mode$') then
    key_table = 'normal_mode'
  end

  return key_table
end

return M
