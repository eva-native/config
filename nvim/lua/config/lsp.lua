local lsp = vim.lsp
local utils = require'utils.lsp'

for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr', 'grt', '<C-S>', 'gO' }) do
  pcall(vim.keymap.del, 'n', bind)
end

utils.on_attach(function (_, bufnr)
  require'config.keymap.lsp'.setup(bufnr)
end)

local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  lsp.config('*', {
    capabilities = cmp_lsp.default_capabilities(),
  })
end

lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      },
      completion = {
        callSnippet = 'Both',
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
      },
      telemetry = {
        enable = false,
      }
    }
  }
})

lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
})

lsp.config('cmake', {
  cmd = { 'cmake-language-server' },
})

vim.diagnostic.config({
  virtual_text = { current_line = false },
  virtual_lines = { current_line = true },
})

vim.lsp.enable({
  'lua_ls', 'clangd', 'bashls', 'gopls', 'pyright', 'cmake'
})
