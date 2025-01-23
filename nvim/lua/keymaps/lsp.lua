local M = {}
local kh = require('keymaps.helpers')

local buf_opts = function(bufnr)
  return function(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = 'LSP: ' .. desc }
  end
end

M.setup_lsp_keymaps = function(bufnr)
  local opts = buf_opts(bufnr)

  kh.map({'n', 'v'}, '<leader>ra', vim.lsp.buf.code_action, opts 'Code action')
  kh.map('n', '<leader>rr', vim.lsp.buf.rename, opts 'Rename symbol')
  kh.map('n', '<leader>rf', function() vim.lsp.buf.format { async = true } end, opts 'Rename symbol')

  kh.map('n', 'gl', vim.diagnostic.open_float, opts 'Show diagnostic')
  kh.map('n', '[d', vim.diagnostic.goto_prev, opts 'Prev error')
  kh.map('n', ']d', vim.diagnostic.goto_next, opts 'Next error')

  kh.map('n', 'gD', vim.lsp.buf.declaration, opts 'Go to declaration')
  kh.map('n', 'gd', vim.lsp.buf.definition, opts 'Go to definition')
  kh.map('n', 'gi', vim.lsp.buf.implementation, opts 'Go to implementation')
  kh.map('n', 'gr', vim.lsp.buf.references, opts 'Go to references')

  kh.map('n', '<C-k>', vim.lsp.buf.signature_help, opts 'Signature help')
  kh.map('n', 'K', vim.lsp.buf.hover, opts 'Hover documentation')
end

M.setup_clangd_ext_keymaps = function(bufnr)
  local opts = buf_opts(bufnr)

  kh.map('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts 'Switch source/header (clangd)')
end

return M
