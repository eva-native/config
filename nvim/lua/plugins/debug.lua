return {
  'mfussenegger/nvim-dap',

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

    local codelldb = vim.fn.stdpath('data')
        .. '/mason/packages/codelldb/extension/adapter/codelldb'

    local function get_program()
      return coroutine.create(function(coro)
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local sorters = require('telescope.config').values
        local actions = require('telescope.actions')
        local actions_state = require('telescope.actions.state')

        local find_job = { 'fd', '--hidden', '--no-ignore', '--type', 'x' }

        local opts = {}

        pickers.new(opts, {
          prompt_title = 'Path to executable',
          finder = finders.new_oneshot_job(find_job, {}),
          sorter = sorters.generic_sorter(opts),
          attach_mappings = function(bufnr)
            actions.select_default:replace(function()
              actions.close(bufnr)
              coroutine.resume(coro, actions_state.get_selected_entry()[1])
            end)
            return true
          end,
        }):find()
      end)
    end

    dap.adapters.codelldb = {
      type = 'executable',
      command = codelldb,
    }

    dap.configurations.cpp = {
      {
        type = 'codelldb',
        name = 'Launch',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = get_program,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,

  keys = {
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'Debug: Conditional Breakpoint',
    },

    { '<leader>dr', function() require('dap').continue() end,  desc = 'Debug: Continue / Start Debuging' },
    { '<leader>dR', function() require('dap').restart() end,   desc = 'Debug: Restart' },
    { '<leader>ds', function() require('dap').step_over() end, desc = 'Debug: Step over' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step into' },
    { '<leader>do', function() require('dap').step_out() end,  desc = 'Debug: Step out' },

    { '<leader>dU', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
    { '<leader>du', function() require('dapui').toggle() end,  desc = 'Debug: Toggle DAP UI' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
    { '<leader>dp', function() require('dap').pause() end,     desc = 'Debug: Pause' },
  },
}
