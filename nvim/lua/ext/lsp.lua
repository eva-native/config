local lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local lspkeymaps = require('keymaps.lsp')

local on_attach = function(_, bufnr)
  lspkeymaps.setup_lsp_keymaps(bufnr)
end

local clangd_ext_avail, clangd_ext = pcall(require, 'clangd_extensions.inlay_hints')

lsp.setup {
  ensure_installed = {
    'clangd', 'gopls', 'rust_analyzer', 'bashls', 'lua_ls', 'pyright'
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        on_attach = on_attach,
      }
    end,
    ['clangd'] = function()
      lspconfig.clangd.setup {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        on_attach = function(_, bufnr)
          if clangd_ext_avail then
            clangd_ext.setup_autocmd()
            clangd_ext.set_inlay_hints()
            lspkeymaps.setup_clangd_ext_keymaps(bufnr)
          end
          on_attach(bufnr)
        end
      }
    end,
    ['lua_ls'] = function()
      lspconfig.lua_ls.setup {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        on_attach = on_attach,
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
      }
    end
  },
}

