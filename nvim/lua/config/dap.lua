local dap = require('dap')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.config').values
local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')

local uv = vim.uv or vim.loop

local find_job = { 'fd', '--hidden', '--no-ignore', '--type', 'x' }

local function get_program()
  return coroutine.create(function(coro)
    local opts = {}
    pickers.new(opts, {
      prompt_title = 'Path to executable',
      finder = finders.new_oneshot_job(find_job, {}),
      sorter = sorters.generic_sorter(opts),
      attach_mappings = function (bufnr)
        actions.select_default:replace(function ()
          actions.close(bufnr)
          coroutine.resume(coro, actions_state.get_selected_entry()[1])
        end)
        return true
      end,
    }):find()
  end)
end

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  options = {
    detached = uv.os_uname() ~= 'Windows',
  },
}

dap.configurations.c = {
  {
    type = 'lldb',
    name = 'Debug',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = get_program,
  },
  {
    type = 'lldb',
    name = 'Attach',
    request = 'attach',
    cwd = '${workspaceFolder}',
    args = {},
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

