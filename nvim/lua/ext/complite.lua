local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local autopairs = require('nvim-autopairs.completion.cmp')
local clangd = require('clangd_extensions.cmp_scores')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'emoji' },
    { name = 'cmdline' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lsp_signature_help = '[LSP Sign]',
        nvim_lua = '[LUA]',
        buffer = '[Buffer]',
        path = '[Path]',
        emoji = '[Emoji]',
        cmdline = '[CMD]',
      })
    })
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      clangd,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    }
  }
})

cmp.event:on('confirm_done', autopairs.on_confirm_done())
