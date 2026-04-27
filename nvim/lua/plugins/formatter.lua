return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true }, function(err, did_edit)
            if not err and did_edit then
              vim.notify('Formatted', vim.log.levels.INFO)
            end
          end)
        end,
        desc = 'Format buffer',
      },
    },
    init = function()
      vim.o.formatexpr = [[v:lua.require 'conform'.formatexpr()]]
    end,
  },
}
