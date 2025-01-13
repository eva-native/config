local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd fonts
vim.g.have_nerd_font = true

opt.mouse = 'a'

opt.number = true
opt.showmode = false
opt.lazyredraw = true
opt.showtabline = 2

vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.breakindent = true
opt.smartindent = true

opt.ignorecase = false
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', extends = '⟩', precedes = '⟨' }

opt.cursorline = true
opt.scrolloff = 10

opt.inccommand = 'split'

opt.swapfile = false

opt.confirm = true
opt.autoread = true

require('keymaps.system')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('uzxftgrp', {}),
  desc = 'Use tabs based on FileType',
  pattern = 'go',
  callback = function()
    vim.bo.expandtab = false
    vim.bo.softtabstop = 0
    vim.bo.shiftwidth = 0
  end
})

