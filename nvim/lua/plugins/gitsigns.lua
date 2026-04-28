return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      -- Keymaps intentionally left unbound. Uncomment and adjust as desired.
      -- local gs = require('gitsigns')
      -- local function map(mode, lhs, rhs, desc)
      --   vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      -- end
      --
      -- map('n', ']h', function() gs.nav_hunk('next') end, 'Next hunk')
      -- map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev hunk')
      --
      -- map('n', '<leader>hs', gs.stage_hunk,                                 'Stage hunk')
      -- map('n', '<leader>hr', gs.reset_hunk,                                 'Reset hunk')
      -- map('n', '<leader>hp', gs.preview_hunk,                               'Preview hunk')
      -- map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
      -- map('n', '<leader>hd', gs.diffthis,                                   'Diff this')
      -- map('n', '<leader>hB', gs.toggle_current_line_blame,                  'Toggle line blame')
    end,
  },
}
