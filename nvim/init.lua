require('settings')

local ok, lazy = pcall(require, 'bootstrap_lazy')
if not ok then
  vim.notify('error while loading lazy.nvim', vim.log.levels.ERROR)
  vim.fn.getchar()
  return
end

lazy.setup('plugins')
