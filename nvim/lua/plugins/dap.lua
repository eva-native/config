local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

  config = vim.deepcopy(config)
  config.args = function ()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str))
    if config.type and config.type == 'java' then
      return new_args
    end
    return require('dap.utils').splitstr(new_args)
  end
  return config
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      { 'theHamsta/nvim-dap-virtual-text', opts = {}, },
      { 'leoluz/nvim-dap-go', config = true },
      { 'julianolf/nvim-dap-lldb', config = true },
    },
    keys = function()
      local dap = require('dap')
      return {
        { '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
        { '<leader>db', function() dap.toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
        { '<leader>dc', function() dap.continue() end, desc = 'Run/Continue' },
        { '<leader>da', function() dap.continue({ before = get_args }) end, desc = 'Run with Args' },
        { '<leader>dC', function() dap.run_to_cursor() end, desc = 'Run to cursor' },
        { '<leader>dg', function() dap.goto_() end, desc = 'Go to Line (no execute)' },
        { '<leader>di', function() dap.step_into() end, desc = 'Step into' },
        { '<leader>dj', function() dap.down() end, desc = 'Down' },
        { '<leader>dk', function() dap.up() end, desc = 'Up' },
        { '<leader>dl', function() dap.run_last() end, desc = 'Run last' },
        { '<leader>do', function() dap.step_out() end, desc = 'Step out' },
        { '<leader>dO', function() dap.step_over() end, desc = 'Step over' },
        { '<leader>dP', function() dap.pause() end, desc = 'Pause' },
        { '<leader>dr', function() dap.repl.toggle() end, desc = 'REPL' },
        { '<leader>ds', function() dap.session() end, desc = 'Session' },
        { '<leader>dt', function() dap.terminate() end, desc = 'Terminate' },
        { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Terminate' },
      }
    end,
    opts = function() end,
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      local vscode = require('dap.ext.vscode')
      local json = require('plenary.json')
      vscode.json_decode = function(s)
        return vim.json.decode(json.json_strip_comments(s))
      end
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    keys = {
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'DAP ui' },
      { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
    },
    opts = {},
    config = function (_, opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function ()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function ()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function ()
        dapui.close({})
      end
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'mason.nvim' },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      ensure_installed = {
        'codelldb'
      },
    },
    config = function() end
  }
}
