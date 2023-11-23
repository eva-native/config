local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local clangd = require("clangd_extensions.cmp_scores")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
    ["<CR>"] = cmp.config.disable,                      -- Turn off autocomplete on <CR>
    ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Turn on autocomplete on <C-y>
    -- Use <C-e> to abort autocomplete
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(), -- Abort completion
      c = cmp.mapping.close(), -- Close completion window
    }),

    -- Use <C-p> and <C-n> to navigate through completion variants
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },                -- LSP
    { name = "nvim_lsp_signature_help" }, -- LSP for parameters in functions
    { name = "nvim_lua" },                -- Lua Neovim API
    { name = "luasnip" },                 -- Luasnip
    { name = "buffer" },                  -- Buffers
    { name = "path" },                    -- Paths
    { name = "emoji" },                   -- Emoji
  }, {}),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol", -- Show only symbol annotations
      maxwidth = 50,   -- Prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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
    },
  },
})
