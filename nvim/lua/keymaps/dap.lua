local dap = require('dap')

local km = vim.keymap.set
local opts = { noremap = true, silent = true }

km('n', '<leader>dd', dap.continue, opts)
km('n', '<leader>db', dap.toggle_breakpoint, opts)
km('n', '<leader>dr', dap.repl.open, opts)
km('n', '<leader>dq', dap.terminate, opts)

km('n', '<F5>', dap.continue, opts)
km('n', '<F10>', dap.step_over, opts)
km('n', '<F11>', dap.step_into, opts)
km('n', '<F12>', dap.step_out, opts)
