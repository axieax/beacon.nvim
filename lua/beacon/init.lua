local M = {}

local config_module = require('beacon.config')
local utils = require('beacon.utils')
local fader = require('beacon.fader')

M.cursor_moved = function()
  fader.cursor_move()
end

M.highlight_position = function(is_force)
  fader.highlight_position(is_force)
end

M.clear_highlight = function()
  fader.clear_highlight()
end

M.beacon_on = function()
  fader.beacon_on()
end

M.beacon_off = function()
  fader.beacon_off()
end

M.beacon_toggle = function()
  fader.beacon_toggle()
end

M.load = function()
  fader.setup(config_module.items)
  utils.create_default_highlight_group()

  local ac = [[
        augroup BeaconHighlightMoves
            autocmd!
    ]]
  if config_module.items.show_jumps then
    ac = ac .. [[
                silent autocmd CursorMoved * lua require'beacon'.cursor_moved()
        ]]
  end
  if config_module.items.focus_gained then
    ac = ac .. [[
                silent autocmd FocusGained * lua require'beacon'.highlight_position(false)
        ]]
  end
  ac = ac
    .. [[
            silent autocmd WinEnter * lua vim.schedule(function() require'beacon'.highlight_position(false) end)
            silent autocmd CmdwinLeave * lua require'beacon'.clear_highlight()
        augroup end
    ]]
  vim.cmd(ac)
  vim.cmd([[
        command! Beacon lua require'beacon'.highlight_position(true)
        command! BeaconOn lua require'beacon'.beacon_on()
        command! BeaconOff lua require'beacon'.beacon_off()
        command! BeaconToggle lua require'beacon'.beacon_toggle()
    ]])
end

M.setup = function(opts)
  config_module.merge_config(opts)
  fader.setup(config_module.items)
end

return M
