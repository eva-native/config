require('mason').setup()
local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')

local lsp_keymap = require('keymaps.lsp')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lsp.setup({
  ensure_installed = {
    'clangd',
    'gopls',
    'tsserver',
    'cmake',
    'bashls',
    'pyright',
    'lua_ls'
  }
})

local on_attach = function(_, bufnr)
  lsp_keymap.setup_lsp_keymaps(bufnr)
end

mason_lsp.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      flags = { debounce_text_changes = 150 },
      capabilities = capabilities,
    })
  end,

  ['clangd'] = function()
    require('clangd_extensions').setup {
      inlay_hints = {
        inline = false,
        only_current_line = false,
        only_current_line_autocmd = { "CursorHold" },
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
        priority = 100,
      },
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        ["template argument"] = "",
      },
      kind_icons = {
        Compound = "",
        Recovery = "",
        TranslationUnit = "",
        PackExpansion = "",
        TemplateTypeParm = "",
        TemplateTemplateParm = "",
        TemplateParamObject = "",
      },
    }
    lspconfig['clangd'].setup({
      on_attach = function(_, bufnr)
        require('clangd_extensions.inlay_hints').setup_autocmd()
        require('clangd_extensions.inlay_hints').set_inlay_hints()
        on_attach(_, bufnr)
      end,
      flags = { debounce_text_changes = 150 },
      capabilities = capabilities,
    })
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = { debounce_text_changes = 150 },
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }, -- Распознавание глобальной переменной vim
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true), -- Добавление runtime библиотек
          },
        },
      },
    }
  end
})
