local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
  'Hello world senior developer'
}

dashboard.section.buttons.val = {
  dashboard.button("e", "📝  > New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "🔍  > Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "📂  > Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "⚙   > Settings", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "🚪  > Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
