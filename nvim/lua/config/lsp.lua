local lsp = vim.lsp
local utils = require'utils.lsp'

for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr', 'grt', '<C-S>', 'gO' }) do
  pcall(vim.keymap.del, 'n', bind)
end

utils.on_attach(function (_, bufnr)
  require'config.keymap.lsp'.setup(bufnr)
end)

lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      }
    }
  }
})

lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = {
    current_line = true
  }
})
