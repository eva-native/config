local map = require('util.keymap').safe_keymap_set

vim.keymap.set('n', '<left>', '<cmd>echo "Use \'h\' to move!!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use \'l\' to move!!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use \'j\' to move!!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use \'k\' to move!!!"<CR>')

map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { desc = 'Up', expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

map({ 'i', 'n', 's' }, '<esc>', function ()
  vim.cmd[[noh]]
  require('util.cmp').actions.snippet_stop()
  return '<esc>'
end, { expr = true, desc = "Escape and Clear hlsearch" })

map('v', '<', '<gv')
map('v', '>', '>gv')

