return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
    cmd = 'Neotree',
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignore = false,
          hide_by_name = {
            '.git',
          },
        },
        follow_current_file = { enabled = false },
      },
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['Y'] = {
            function(state)
              local n = state.tree:get_node()
              local p = n:get_id()
              vim.fn.setreg('+', p, 'c')
            end,
            desc = 'Copy path to clipboard',
          },
          ['P'] = { 'toggle_preview', config = { use_float = true } },
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute({
              action = 'close',
            })
          end,
        },
      }
    },
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute({
            toggle = true,
          })
        end,
        desc = 'Explorer NeoTree (root)',
      },
    },
  },
}
