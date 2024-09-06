local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Turn on autocomplete on <C-y>
    -- Use <C-e> to abort autocomplete
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(), -- Abort completion
      c = cmp.mapping.close(), -- Close completion window
    }),

    -- Use <C-p> and <C-n> to navigate through completion variants
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'emoji' },
  },
  formatting = {
    format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
  },
}

local ok, autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if ok then
  cmp.event:on('confirm_done', autopairs.on_confirm_done())
end
