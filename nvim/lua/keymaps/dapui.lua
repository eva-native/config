local dapui = require('dapui')

local km = vim.keymap.set
local opts = { noremap = true, silent = true }

km('n', '<leader>du', dapui.toggle, opts)
