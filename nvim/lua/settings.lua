require("helpers")

vim.scriptencoding = "utf-8"

g.mapleader = " "
g.maplocalleader = " "

-- Editor options

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.ruler = true
opt.title = true
opt.clipboard = "unnamedplus"
opt.syntax = "on"
opt.encoding = "utf-8"
opt.hidden = true
opt.ttimeoutlen = 0
opt.wildmenu = true
opt.showcmd = true

opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true

opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true

opt.mouse = "a"

opt.scrolloff = 999
opt.colorcolumn = "121"

-- Tabs

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
