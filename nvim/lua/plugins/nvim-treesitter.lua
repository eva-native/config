return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local ensure_installed = { 'lua', 'cpp', 'go', 'json' }
      local already_installed =
        require('nvim-treesitter.config').get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
      require('nvim-treesitter').install(to_install)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = [[v:lua.require'nvim-treesitter'.indentexpr()]]
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.g.no_plugin_maps = true
    end,
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = 'V',
        },
      },
      move = { set_jumps = true },
    },
    keys = function()
      local select_textobject =
        require('nvim-treesitter-textobjects.select').select_textobject
      local move = require('nvim-treesitter-textobjects.move')
      local swap = require('nvim-treesitter-textobjects.swap')

      local sel_modes = { 'x', 'o' }
      local mv_modes = { 'n', 'x', 'o' }

      local select_pairs = {
        f = '@function',
        c = '@class',
        a = '@parameter',
        o = '@loop',
        i = '@conditional',
        k = '@block',
        m = '@comment',
      }
      for key, capture in pairs(select_pairs) do
        vim.keymap.set(sel_modes, 'a' .. key, function()
          select_textobject(capture .. '.outer')
        end, { desc = 'Select around ' .. capture })
        vim.keymap.set(sel_modes, 'i' .. key, function()
          select_textobject(capture .. '.inner')
        end, { desc = 'Select inside ' .. capture })
      end

      local move_pairs = {
        f = '@function.outer',
        c = '@class.outer',
        a = '@parameter.inner',
      }
      for key, capture in pairs(move_pairs) do
        local up = key:upper()
        vim.keymap.set(mv_modes, ']' .. key, function()
          move.goto_next_start(capture)
        end, { desc = 'Next ' .. capture .. ' start' })
        vim.keymap.set(mv_modes, '[' .. key, function()
          move.goto_previous_start(capture)
        end, { desc = 'Prev ' .. capture .. ' start' })
        vim.keymap.set(mv_modes, ']' .. up, function()
          move.goto_next_end(capture)
        end, { desc = 'Next ' .. capture .. ' end' })
        vim.keymap.set(mv_modes, '[' .. up, function()
          move.goto_previous_end(capture)
        end, { desc = 'Prev ' .. capture .. ' end' })
      end

      vim.keymap.set('n', '<leader>xa', function()
        swap.swap_next('@parameter.inner')
      end, { desc = 'Swap parameter with next' })
      vim.keymap.set('n', '<leader>xA', function()
        swap.swap_previous('@parameter.inner')
      end, { desc = 'Swap parameter with previous' })
    end,
  },
}
