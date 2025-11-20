local utils, lsp_utils = require('util.lsp'), require('lspconfig.util')
local icons = require('config.icons').diagnostics

---@type vim.diagnostic.Opts
local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
  severity_sort = true,
  signs = {
    [vim.diagnostic.severity.ERROR] = icons.Error,
    [vim.diagnostic.severity.WARN] = icons.Warn,
    [vim.diagnostic.severity.INFO] = icons.Info,
    [vim.diagnostic.severity.HINT] = icons.Hint,
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config('clangd', {
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
    '--offset-encoding=utf-16'
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr', 'grt', '<C-S>', 'gO' }) do
  pcall(vim.keymap.del, 'n', bind)
end

utils.setup()
utils.on_attach(function (_, bufnr)
  require('config.keymap.lsp').setup(bufnr)
end)

if vim.fn.has('nvim-0.10.0') == 0 then
  for severity, icon in pairs(diagnostics.signs) do
    local name = 'DiagnosticSign' .. vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
  end
end

utils.on_supports_method('textDocument/inlayHint', function (_, bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == '' then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end)

if vim.lsp.codelens then
  utils.on_supports_method('textDocument/codeLens', function (_, bufnr)
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh
    })
  end)
end

vim.diagnostic.config(diagnostics)

