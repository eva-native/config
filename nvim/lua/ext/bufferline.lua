if true then return end

local bufferline = require('bufferline')

bufferline.setup {
  options = {
    mode = 'tabs',
    style_preset = bufferline.style_preset.minimal,
    themable = true,
    separator_style = 'thin',
    diagnostics = 'nvim_lsp',
    custom_filter = function(buf, _)
      if vim.bo[buf].filetype ~= 'NvimTree' then
        return true
      end
    end
  }
}
