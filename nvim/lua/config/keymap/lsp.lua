local M = {}

function M._get()
  if M._keys then return M._keys end

  local telescope = require('telescope.builtin')

  M._keys = {
    { 'gd',         telescope.lsp_definitions,                            desc = 'Goto definition' },
    { 'gr',         telescope.lsp_references,                             desc = 'Goto references' },
    { 'gI',         telescope.lsp_implementations,                        desc = 'Goto implementations' },

    { '<leader>ca', vim.lsp.buf.code_action,                              desc = 'Code action' },
    { '<leader>cr', vim.lsp.buf.rename,                                   desc = 'LSP rename' },

    { 'K',          vim.lsp.buf.hover,                                    desc = 'Hover documentation' },

    { '<leader>ss', telescope.lsp_document_symbols,                       desc = 'Goto symbol' },
    { '<leader>sS', telescope.lsp_dynamic_workspace_symbols,              desc = 'Goto symbol (workspace)' },
    { '<leader>sd', function() telescope.diagnostics({ bufnr = 0 }) end,  desc = 'Document diagnostics' },
    { '<leader>sD', telescope.diagnostics,                                desc = 'Workspace diagnostics' },
  }

  return M._keys
end

function M.setup(bufnr)
  local keys = require 'lazy.core.handler.keys'
  local spec = keys.resolve(M._get())

  for _, key in pairs(spec) do
    local opts = keys.opts(key)
    opts.silent = true
    opts.buffer = bufnr
    vim.keymap.set(key.mode or 'n', key.lhs, key.rhs, opts)
  end
end

return M
