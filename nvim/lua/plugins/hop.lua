return {
  'smoka7/hop.nvim',
  version = "*",
  event = 'BufRead',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
  },
  keys = function ()
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    return {
      { '<leader>,', hop.hint_char1, desc = 'Jump to char' },
      { '<leader>w', hop.hint_words, desc = 'Jump to word' },
      { '<leader>l', hop.hint_vertical, desc = 'Jump to line' },

      { 'f', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR, current_line_only = true
        })
      end, mode = '', remap = true },
      { 'F', function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR, current_line_only = true
        })
      end, mode = '', remap = true },
      { 't', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1
        })
      end, mode = '', remap = true },
      { 'F', function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = -1
        })
      end, mode = '', remap = true },
    }
  end
}
