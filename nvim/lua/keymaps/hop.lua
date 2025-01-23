local kh = require('keymaps.helpers')
local M = {}

M.setup = function(hop)
  -- TODO: find ergonomic keymaps
  kh.map('', '<leader>,', hop.hint_char1, kh.default_opts 'Jump to char')
  kh.map('', '<leader>w', hop.hint_words, kh.default_opts 'Jump to word')
  kh.map('', '<leader>l', hop.hint_vertical, kh.default_opts 'Jump to line')
end

return M

