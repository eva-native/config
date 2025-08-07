local M = {}
local kh = require('keymaps.helpers')
local telescope_ok, builtin = pcall(require, 'telescope.builtin')

local function dispatch_action(t, f)
  return (telescope_ok and t) or (f)
end

local lsp = vim.lsp

local lsp_actions = {
  references = dispatch_action(builtin.lsp_references, lsp.buf.references),
  implementation = dispatch_action(builtin.lsp_implementations, lsp.buf.implementation),
  definition = dispatch_action(builtin.lsp_definitions, lsp.buf.definition),
  type_definition = dispatch_action(builtin.lsp_type_definitions, lsp.buf.type_definition),
  incoming_calls = dispatch_action(builtin.lsp_incoming_calls, vim.lsp.buf.incoming_calls),
  outgoing_calls = dispatch_action(builtin.lsp_outgoing_calls, vim.lsp.buf.outgoing_calls),
  document_symbols = dispatch_action(builtin.lsp_document_symbols, vim.lsp.buf.document_symbol),
  workspace_symbols = dispatch_action(builtin.lsp_workspace_symbols, vim.lsp.buf.workspace_symbol),
  dynamic_workspace_symbols = dispatch_action(builtin.lsp_dynamic_workspace_symbols, vim.lsp.buf.workspace_symbol),
  diagnostics = dispatch_action(builtin.diagnostics, function ()
    vim.notify('telescope diagnostics unavailable', vim.log.levels.WARN)
  end),
}

local default_opts = { silent = true }

local function opts(desc, others)
  return vim.tbl_extend('force', default_opts, { desc = desc }, others or {})
end

function M.setup_lsp_keymaps()
  kh.map({'n', 'v'}, '<leader>ra', lsp.buf.code_action, opts 'Code action')
  kh.map('n', '<leader>rr', lsp.buf.rename, opts 'Rename symbol')
  kh.map('n', '<leader>rf', function() lsp.buf.format { async = true } end, opts 'Format')

  kh.map('n', '<leader>ld', lsp_actions.diagnostics, opts 'Show all diagnostics')
  kh.map('n', 'gl', vim.diagnostic.open_float, opts 'Show diagnostic')
  kh.map('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, opts 'Next diagnostic')
  kh.map('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, opts 'Prev diagnostic')

  kh.map('n', '<leader>g/', vim.lsp.buf.declaration, opts 'Go to declaration')
  kh.map('n', '<leader>gd', lsp_actions.definition, opts 'Go to definition')
  kh.map('n', '<leader>gt', lsp_actions.type_definition, opts 'Go to type definition')
  kh.map('n', '<leader>gi', lsp_actions.implementation, opts 'Go to implementation')
  kh.map('n', '<leader>gr', lsp_actions.references, opts 'Go to references')
  kh.map('n', '<leader>gc', lsp_actions.incoming_calls, opts 'Go to incoming calls')
  kh.map('n', '<leader>gC', lsp_actions.outgoing_calls, opts 'Go to outgoing calls')
  kh.map('n', '<leader>gs', lsp_actions.document_symbols, opts 'Go to document symbols')
  kh.map('n', '<leader>gw', lsp_actions.workspace_symbols, opts 'Go to workspace symbols')
  kh.map('n', '<leader>gW', lsp_actions.dynamic_workspace_symbols, opts 'Go to dynamic workspace symbols')

  kh.map('n', '<C-k>', vim.lsp.buf.signature_help, opts 'Signature help')
  -- kh.map('n', 'K', vim.lsp.buf.hover, opts 'Hover documentation')
end

function M.setup_clangd_ext_keymaps()
  kh.map('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts 'Switch source/header (clangd)')
end

return M
