return {
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'p00f/clangd_extensions.nvim',
    },
    opts = function()
      local cmp = require('cmp')
      local cmp_util = require('util.cmp')
      local defaults = require("cmp.config.default")()

      local opts = {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        preselect = cmp.PreselectMode.Item,
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<tab>'] = function (fallback)
            cmp_util.map({ 'snippet_forward', }, fallback)()
          end
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        sorting = defaults.sorting,
      }

      table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))

      return opts
    end
  }
}
