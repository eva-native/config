return {
  'mason-org/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'mason-org/mason.nvim',
      cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonLog', 'MasonUninstall' },
      opts = {},
    },
    'neovim/nvim-lspconfig',
  },
  opts = {
    PATH = 'append',
    ensure_installed = {
      'lua_ls', 'bashls', 'gopls', 'pyright'
    },
    automatic_enable = false,
  }
}
