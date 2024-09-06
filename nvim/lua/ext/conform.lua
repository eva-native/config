local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "goimports", "gofmt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end,
})

require("keymaps.conform")
