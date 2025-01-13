local M = {}

M.map = vim.keymap.set

M.default_opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

return M
