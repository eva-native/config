require("helpers")

local wk = require("which-key")
local dap = require("dap")
local dapui = require("dapui")

-- Misc
wk.add({
  { "<F2>", "<cmd>:nohl<CR>", desc = "Clear search" },
  { "<c-down>", "<C-w>-", desc = "Window: resize window" },
  { "<c-h>", "<C-w>h", desc = "Window: to left" },
  { "<c-j>", "<C-w>j", desc = "Window: to down" },
  { "<c-k>", "<C-w>k", desc = "Window: to up" },
  { "<c-l>", "<C-w>l", desc = "Window: to right" },
  { "<c-left>", "<C-w><", desc = "Window: resize window" },
  { "<c-right>", "<C-w>>", desc = "Window: resize window" },
  { "<c-up>", "<C-w>+", desc = "Window: resize window" },
  { "<down>", function() print("Use j") end, desc = "Use j" },
  { "<leader>x", "<cmd>bd<CR>", desc = "Window: Close bufer" },
  { "<left>", function() print("Use h") end, desc = "Use h" },
  { "<right>", function() print("Use l") end, desc = "Use l" },
  { "<s-tab>", "<cmd>bprevious<CR>", desc = "Window: Next buffer" },
  { "<tab>", "<cmd>bnext<CR>", desc = "Window: Next buffer" },
  { "<up>", function() print("Use k") end, desc = "Use k" },

  { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "LSP: Hover" },
  { "g", group = "Go to" },
  { "gD", "<cmd>Telescope lsp_declaration<CR>", desc = "LSP Go to declaration" },
  { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "LSP Go to definition" },
  { "gr", "<cmd>Telescope lsp_references<CR>", desc = "LSP Go to references" },
  { "<leader>l", group = "LSP" },
  { "<leader>lA", "<cmd>ClangdAST", desc = "LSP show AST" },
  { "<leader>lH", "<cmd>ClangdTypeHierarchy", desc = "LSP show type hierarchy" },
  { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "LSP: Rename" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "LSP: Code action" },
  { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "LSP: Show diagnostic" },
  { "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "LSP: Show signature help" },
  { "<leader>ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "LSP/Telescope: Symbols" },

  { "<leader>l", group = "LSP", mode = "v" },
  { "<leader>lA", "<Esc>:'<,'>ClangdAST<CR>", desc = "LSP/Clangd-extension show AST", mode = "v" },

  { "<leader>t", group = "Telescope" },
  { "<leader>ta", "<cmd>Telescope<CR>", desc = "Telescope: All Actions" },
  { "<leader>tb", "<cmd>Telescope git_branches<CR>", desc = "Telescope: Branches" },
  { "<leader>tf", "<cmd>Telescope find_files<CR>", desc = "Telescope: Find files" },
  { "<leader>tg", "<cmd>Telescope live_grep<CR>", desc = "Telescope: Find" },
  { "<leader>to", "<cmd>Telescope git_files<CR>", desc = "Telescope: Open Git File" },
  { "<leader>tp", "<cmd>Telescope oldfiles<CR>", desc = "Telescope: Recent files" },
  { "<leader>tq", "<cmd>Telescope buffers<CR>", desc = "Telescope: Buffers" },

  { "<F10>", function() dap.step_over() end, desc = "DAP: Step over" },
  { "<F11>", function() dap.step_into() end, desc = "DAP: Step into" },
  { "<F12>", function() dap.step_out() end, desc = "DAP: Step out" },
  { "<F5>", function() dap.continue() end, desc = "DAP: Run/resume debug session" },
  { "<leader>d", group = "DAP" },
  { "<leader>dB", function() dap.set_breakpoint() end, desc = "DAP: Set breakpoint" },
  { "<leader>db", function() dap.toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
  { "<leader>dc", function() dap.set_breakpoint(fn.input("Condition: "), nil, nil) end, desc = "DAP: Set condition breakpoint" },
  { "<leader>df", function() dapui.float_element() end, desc = "DAP: Show float" },
  { "<leader>dp", function() dap.set_breakpoint(nil, nil, fn.input("Log point message: ")) end, desc = "DAP: Set log point" },
  { "<leader>d", group = "DAP", mode = "v" },
  { "<leader>df", function() dapui.float_element() end, desc = "DAP: Show float", mode = "v" },

  { "<leader>v", "<cmd>Neotree toggle<CR>", desc = "Neotree" },
})
