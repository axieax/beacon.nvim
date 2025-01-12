local M = {}

M.items = {
  enable = true,
  size = 40,
  fade = true,
  fader = 'cursor_end',
  minimal_jump = 10,
  show_jumps = true,
  focus_gained = false,
  shrink = true,
  timeout = 500,
  ignore_buffers = {},
  ignore_filetypes = {},
}

M.merge_config = function(opts)
  opts = opts or {}
  M.items = vim.tbl_deep_extend('force', M.items, opts)
end

return M
