local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.timeoutlen = 300
opt.confirm = true

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 8
opt.expandtab = true

opt.wrap = false

opt.showtabline = 2

vim.o.winborder = 'rounded'
opt.pumheight = 10

opt.cursorline = true
opt.scrolloff = 10
opt.colorcolumn = '80'

opt.showmode = false

opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
opt.smartcase = true

opt.inccommand = 'split'

opt.fileencoding = 'utf-8'
opt.swapfile = false
opt.backup = false
opt.writebackup = false

vim.filetype.add({
  filename = {
    [".env"] = 'sh',
  },
})
