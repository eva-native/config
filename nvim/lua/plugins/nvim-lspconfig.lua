return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'clangd', 'gopls', 'rust_analyzer', 'bashls', 'lua_ls', 'pyright', 'html', 'htmx'
      },
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
      require('config.lsp')
    end
  },
}

