local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "json",
    "cmake",
    "python",
  },
  highlight = { enable = true },
  -- indent = { enable = true },
})
