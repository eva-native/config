require("helpers")
local wk = require("which-key")
local dap = require("dap")
local dapui = require("dapui")

local group_names = {
  telescope = "Telescope",
  neotree = "Neotree",
  lsp = "LSP",
  dap = "DAP",
  go = "Go to",
  term = "Terminal",
  window = "Window",
}

-- Misc
wk.register({
  ["<up>"] = { function() print("Use k") end, "Use k" },
  ["<down>"] = { function() print("Use j") end, "Use j" },
  ["<left>"] = { function() print("Use h") end, "Use h" },
  ["<right>"] = { function() print("Use l") end, "Use l" },

  ["<F2>"] = { "<cmd>:nohl<CR>", "Clear search" },

  ["<leader>"] = {
    n = { function() cmd.split(); cmd.terminal() end, group_names.term .. "Show split terminal" },
    x = { "<cmd>bd<CR>", group_names.window .. ": Close bufer" },
  },

  ["<c-h>"] = { "<C-w>h", group_names.window .. ": to left" },
  ["<c-j>"] = { "<C-w>j", group_names.window .. ": to down" },
  ["<c-k>"] = { "<C-w>k", group_names.window .. ": to up" },
  ["<c-l>"] = { "<C-w>l", group_names.window .. ": to right" },

  ["<c-left>"]  = { "<C-w><", group_names.window .. ": resize window" },
  ["<c-right>"] = { "<C-w>>", group_names.window .. ": resize window" },
  ["<c-up>"]    = { "<C-w>+", group_names.window .. ": resize window" },
  ["<c-down>"]  = { "<C-w>-", group_names.window .. ": resize window" },

  ["<tab>"]   = { "<cmd>bnext<CR>",     group_names.window .. ": Next buffer" },
  ["<s-tab>"] = { "<cmd>bprevious<CR>", group_names.window .. ": Next buffer" },
})

-- LSP
wk.register({
  K = { "<cmd>lua vim.lsp.buf.hover()<CR>", group_names.lsp .. ": Hover" },
  g = {
    name = group_names.go,
    d = { "<cmd>Telescope lsp_definitions<CR>", group_names.lsp .. " Go to definition" },
    D = { "<cmd>Telescope lsp_declaration<CR>", group_names.lsp .. " Go to declaration" },
    r = { "<cmd>Telescope lsp_references<CR>",  group_names.lsp .. " Go to references" },
  },
  ["<leader>"] = {
    l = {
      name = group_names.lsp,
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>",           group_names.lsp .. ": Code action" },
      R = { "<cmd>lua vim.lsp.buf.rename()<CR>",                group_names.lsp .. ": Rename" },
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>",         group_names.lsp .. ": Show diagnostic" },
      h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>",        group_names.lsp .. ": Show signature help" },
      s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", group_names.lsp .. "/Telescope: Symbols" },
      A = { "<cmd>ClangdAST",                                   group_names.lsp .. " show AST" },
      H = { "<cmd>ClangdTypeHierarchy",                         group_names.lsp .. " show type hierarchy" },
    }
  }
})

wk.register({
  ["<leader>"] = {
    l = {
      name = group_names.lsp,
      A = { "<Esc>:'<,'>ClangdAST<CR>", group_names.lsp .. "/Clangd-extension show AST" },
    }
  }
}, { mode = "v" })

-- Telescope
wk.register({
  ["<leader>"] = {
    t = {
      name = group_names.telescope,
      p = {"<cmd>Telescope oldfiles<CR>",     group_names.telescope .. ": Recent files"},
      o = {"<cmd>Telescope git_files<CR>",    group_names.telescope .. ": Open Git File"},
      b = {"<cmd>Telescope git_branches<CR>", group_names.telescope .. ": Branches"},
      g = {"<cmd>Telescope live_grep<CR>",    group_names.telescope .. ": Find"},
      q = {"<cmd>Telescope buffers<CR>",      group_names.telescope .. ": Buffers"},
      a = {"<cmd>Telescope<CR>",              group_names.telescope .. ": All Actions"},
      f = {"<cmd>Telescope find_files<CR>",   group_names.telescope .. ": Find files"},
    }
  }
})

-- DAP
wk.register({
  ["<F5>"]  = { function() dap.continue() end,  group_names.dap .. ": Run/resume debug session" },
  ["<F10>"] = { function() dap.step_over() end, group_names.dap .. ": Step over" },
  ["<F11>"] = { function() dap.step_into() end, group_names.dap .. ": Step into" },
  ["<F12>"] = { function() dap.step_out() end,  group_names.dap .. ": Step out" },
  ["<leader>"] = {
    d = {
      name = group_names.dap,
      b = { function() dap.toggle_breakpoint() end, group_names.dap .. ": Toggle breakpoint"},
      B = { function() dap.set_breakpoint() end,    group_names.dap .. ": Set breakpoint"},

      p = { function() dap.set_breakpoint(nil, nil, fn.input("Log point message: ")) end, group_names.dap .. ": Set log point"},
      c = { function() dap.set_breakpoint(fn.input("Condition: "), nil, nil) end,         group_names.dap .. ": Set condition breakpoint"},

      f = { function() dapui.float_element() end, group_names.dap  .. ": Show float" },
   }
  }
})

wk.register({
  ["<leader>"] = {
    d = {
      name = group_names.dap,
      f = { function() dapui.float_element() end, group_names.dap  .. ": Show float" },
    }
  }
}, { mode = "v" })

wk.register({
  ["<leader>v"] = { "<cmd>Neotree toggle<CR>", group_names.neotree }
})
