local kh = require('keymaps.helpers')
local M = {}

M.setup = function (dap, dapui)
  kh.map('n', '<leader>du', dapui.toggle, kh.default_opts 'Toggle [D]ebug [U]I')

  kh.map('n', '<leader>db', dap.toggle_breakpoint, kh.default_opts '[D] Toggle [B]reakpoint')
  kh.map('n', '<leader>dr', dap.repl.open, kh.default_opts '[D] Open [R]EPL')

  kh.map('n', '<F5>', dap.continue, kh.default_opts 'DAP: Run/Continue')
  kh.map('n', '<F10>', dap.step_over, kh.default_opts 'DAP: Step Over')
  kh.map('n', '<F11>', dap.step_into, kh.default_opts 'DAP: Step Into')
  kh.map('n', '<F12>', dap.step_out, kh.default_opts 'DAP: Step Out')
end

return M

