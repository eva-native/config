local M = {}

function M.get()
  if M.keys then
    return M.keys
  end

  local telescope = require('telescope.builtin')
  M.keys = {
    { 'gd', telescope.lsp_definitions, desc = 'Goto definition' },
    { 'gr', telescope.lsp_references, desc = 'Goto references' },
    { 'gI', telescope.lsp_implementations, desc = 'Goto implementations' },
    { 'gy', telescope.lsp_type_definitions, desc = 'Goto type definition' },
    { 'gD', vim.lsp.buf.declaration, desc = 'Goto declaration' },
    { 'go', telescope.lsp_outgoing_calls, desc = 'Goto outgoing calls' },
    { 'gO', telescope.lsp_incoming_calls, desc = 'Goto incoming calls' },

    { 'K', vim.lsp.buf.hover, desc = 'Hover' },
    { 'gK', vim.lsp.buf.signature_help, desc = 'Signature help' },

    { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code action' },
    { '<leader>cc', vim.lsp.codelens.run, desc = 'Codelens' },
    { '<leader>cC', vim.lsp.codelens.refresh, desc = 'Codelens refresh' },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'LSP Rename' },
  }
  return M.keys
end

function M.setup(bufnr)
  local Keys = require('lazy.core.handler.keys')
  local spec = Keys.resolve(M.get())

  for _, key in pairs(spec) do
    local opts = Keys.opts(key)
    opts.silent = true
    opts.buffer = bufnr
    vim.keymap.set(key.mode or 'n', key.lhs, key.rhs, opts)
  end
end

return M
