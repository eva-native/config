local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local mason_dap = require("mason-nvim-dap")
local lspconfig = require("lspconfig")

mason.setup()

mason_lsp.setup({
  ensure_installed = {
    "lua_ls",             -- LSP for Lua language
    "pyright",            -- LSP for Python
    "clangd",             -- LSP for C/C++
    "cmake",              -- LSP for CMake
    "rust_analyzer",      -- LSP for Rust
    "bashls",             -- LSP for Bash
    "tsserver"            -- LSP for JS/TS
  }
})

mason_lsp.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({})
  end,

  ["clangd"] = function()
    lspconfig["clangd"].setup({
      on_attach = function()
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
      end,
    })
  end,
})

mason_dap.setup({
  ensure_installed = {
    "codelldb"            -- DAP for C/C++
  },

  handlers = {
    function(config)
      mason_dap.default_setup(config)
    end,
  },
})
