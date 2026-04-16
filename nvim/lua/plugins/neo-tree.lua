return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  opts = {
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function ()
          require 'neo-tree.command'.execute {
            action = 'close',
          }
        end,
      },
    },
  },
  keys = {
    {
      '<leader>e',
      function ()
        require 'neo-tree.command'.execute {
          toggle = true,
        }
      end,
      desc = 'Toggle FS explorer (root)',
    }
  },
}
