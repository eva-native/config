local dap = require('dap')

local codelldb = vim.fn.stdpath('data')..'/mason/packages/codelldb/extension/adapter/codelldb'

local function get_program()
  return coroutine.create(function (coro)
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
        actions.select_default:replace(function ()
          actions.close(bufnr)
          coroutine.resume(coro, actions_state.get_selected_entry()[1])
        end)
        return true
      end
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
  }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
