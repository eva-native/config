local keymaps = require('keymaps.lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      },
    },
  },
})

for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt", "<C-S>" }) do
  pcall(vim.keymap.del, "n", bind)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    keymaps.setup_lsp_keymaps()
  end
})

