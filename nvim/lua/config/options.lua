vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.have_nerd_font = true

local opt = vim.opt

opt.mouse = 'a'

opt.number = true
opt.showtabline = 2

vim.schedule(function ()
  opt.clipboard = 'unnamedplus'
end)

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 8
opt.expandtab = true

opt.breakindent = true
opt.smartindent = true

opt.cursorline = true
opt.scrolloff = 4
opt.colorcolumn = "80"

opt.list = true
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '⟩',
  precedes = '⟨'
}

opt.ignorecase = false
opt.incsearch = true
opt.hlsearch = true

opt.inccommand = 'split'

opt.confirm = true

opt.lazyredraw = true
opt.swapfile = false

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function()
    vim.hl.on_yank({
      higroup = 'Visual',
      on_visual = false,
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Go use tabs instead space',
  pattern = 'go',
  callback = function ()
    vim.bo.expandtab = false
    vim.bo.softtabstop = 0
    vim.bo.shiftwidth = 0
  end
})

