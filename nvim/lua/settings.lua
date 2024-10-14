vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = false
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn='yes'

vim.opt.swapfile = false

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.timeoutlen = 500            -- Время ожидания клавиатурной комбинации (мс)
vim.opt.updatetime = 300            -- Время ожидания перед обновлением (мс)

vim.opt.showtabline = 2             -- Всегда показывать линию вкладок
vim.opt.cmdheight = 2               -- Высота командной строки (чтобы видеть больше сообщений)

vim.opt.lazyredraw = true
vim.opt.showmode = false
vim.opt.laststatus = 2              -- Всегда показывать статусную строку
vim.opt.shortmess:append("c")       -- Не показывать лишние сообщения об автодополнении
vim.opt.mouse = "a"

vim.opt.list = true                 -- Включить отображение специальных символов
vim.opt.listchars = { trail = '·', tab = '▸ ', extends = '⟩', precedes = '⟨', nbsp = '␣' }
vim.opt.colorcolumn = "120"

vim.opt.confirm = true              -- Подтверждать закрытие файлов с несохраненными изменениями
vim.opt.autoread = true             -- Автоматически перечитывать файл, если он изменен извне

vim.opt.formatoptions:remove("cro") -- Отключить автозакрытие комментариев при вставке текста
vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize" -- Настройки для сессий

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('keymaps.system')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight yank', {clear = true}),
  callback = function()
    vim.highlight.on_yank()
  end
})

