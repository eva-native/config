local M = {}
local kh = require('keymaps.helpers')
local telescope_ok, builtin = pcall(require, 'telescope.builtin')

local function dispatch_action(t, f)
  return (telescope_ok and t) or (f)
end

local function dummy() end

local lsp_actions = {
  references = dispatch_action(builtin.lsp_references, vim.lsp.buf.references),
  implementation = dispatch_action(builtin.lsp_implementations, vim.lsp.buf.implementation),
  definition = dispatch_action(builtin.lsp_definitions, vim.lsp.buf.definition),
  type_definition = dispatch_action(builtin.lsp_type_definitions, vim.lsp.buf.type_definition),
  incoming_calls = dispatch_action(builtin.lsp_incoming_calls, vim.lsp.buf.incoming_calls),
  outgoing_calls = dispatch_action(builtin.lsp_outgoing_calls, vim.lsp.buf.outgoing_calls),
  document_symbols = dispatch_action(builtin.lsp_document_symbols, vim.lsp.buf.document_symbol),
  workspace_symbols = dispatch_action(builtin.lsp_workspace_symbols, vim.lsp.buf.workspace_symbol),
  dynamic_workspace_symbols = dispatch_action(builtin.lsp_dynamic_workspace_symbols, vim.lsp.buf.workspace_symbol),
  diagnostics = dummy,
}

lsp_actions.diagnostics = dispatch_action(builtin.diagnostics, function ()
  vim.notify('telescope diagnostics unavailable', vim.log.levels.WARN)
  lsp_actions.diagnostics = dummy
end)

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

  kh.map('n', '<leader>ld', lsp_actions.diagnostics, opts 'Show all diagnostics')
  kh.map('n', 'gl', vim.diagnostic.open_float, opts 'Show diagnostic')
  kh.map('n', '[d', vim.diagnostic.goto_prev, opts 'Prev error')
  kh.map('n', ']d', vim.diagnostic.goto_next, opts 'Next error')

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
  kh.map('n', 'K', vim.lsp.buf.hover, opts 'Hover documentation')
end

M.setup_clangd_ext_keymaps = function(bufnr)
  local opts = buf_opts(bufnr)

  kh.map('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts 'Switch source/header (clangd)')
end

return M
