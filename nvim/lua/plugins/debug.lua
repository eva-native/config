return {
  'mfussenegger/nvim-dap',

  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'jay-babu/mason-nvim-dap.nvim',
  },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open {}
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end

    require('mason-nvim-dap').setup {
      ensure_installed = {
        'codelldb',
      }
    }
  end,

  keys = function ()
    local dap = require('dap')

    return {
      { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, desc = 'Debug: Conditional Breakpoint' },

      { '<leader>dr', dap.continue, desc = 'Debug: Continue / Start Debuging' },
      { '<leader>dR', dap.restart, desc = 'Debug: Restart' },
      { '<leader>ds', dap.step_over, desc = 'Debug: Step over' },
      { '<leader>di', dap.step_into, desc = 'Debug: Step into' },
      { '<leader>do', dap.step_out, desc = 'Debug: Step out' },

      { '<leader>dU', dap.repl.open, desc = 'Debug: Open REPL' },
      { '<leader>du', function()
        require('dapui').toggle()
      end, desc = 'Debug: Toggle DAP UI' },
      { '<leader>dt', dap.terminate, desc = 'Debug: Terminate' },
      { '<leader>dp', dap.pause, desc = 'Debug: Pause' },
    }
  end
}
