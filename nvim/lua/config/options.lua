local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.mouse = 'a'

opt.number = true
opt.relativenumber = true

opt.showtabline = 2

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 8
opt.expandtab = true

opt.termguicolors = true

opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.colorcolumn = '80'
opt.wrap = false

opt.timeoutlen = 300

opt.ignorecase = false
opt.incsearch = true
opt.hlsearch = true
opt.inccommand = 'split'
opt.confirm = true

require('config.keymap.generic')
