local theme = require('config.colorscheme')
if theme.name ~= "rose-pine" then return {} end

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  config = function()
    require('rose-pine').setup({
      styles = {
        transparency = true,
      },
    })
    vim.cmd[[colorscheme rose-pine]]
  end
}
