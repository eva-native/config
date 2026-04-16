return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function ()
      local cmp = require'cmp'

      local conf = {
        snippet = {
          expand = function (args)
            require'luasnip'.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert
          },
          ['<C-p>'] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert
          },
          ['<C-y>'] = cmp.mapping.confirm({ select = true })
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        })
      }

      return conf
    end,
  }
}
