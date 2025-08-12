return {
  'nvim-lualine/lualine.nvim',
  opts = function ()
    local lualine_require = require('lualine_require')
    lualine_require.require = require

    local opts = {
      options = {
        theme = 'auto',
        disabled_filetypes = { statusline = { 'alpha' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff'  },
        lualine_c = { 'diagnostics', 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tab_line = {},
      extensions = { 'neo-tree', 'lazy', 'fzf' },
    }

    return opts
  end
}
