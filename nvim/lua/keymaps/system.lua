local kh = require('keymaps.helpers')

kh.map('n', '<left>', '<cmd>echo "Use \'h\' to move!!!"<CR>')
kh.map('n', '<right>', '<cmd>echo "Use \'l\' to move!!!"<CR>')
kh.map('n', '<down>', '<cmd>echo "Use \'j\' to move!!!"<CR>')
kh.map('n', '<up>', '<cmd>echo "Use \'k\' to move!!!"<CR>')

kh.map('n', '<Esc>', '<cmd>nohlsearch<CR>', kh.default_opts 'No highlight search')

kh.map('n', '<C-h>', '<C-w><C-h>', kh.default_opts 'Move focus to the left window')
kh.map('n', '<C-l>', '<C-w><C-l>', kh.default_opts 'Move focus to the right window')
kh.map('n', '<C-j>', '<C-w><C-j>', kh.default_opts 'Move focus to the lower window')
kh.map('n', '<C-k>', '<C-w><C-k>', kh.default_opts 'Move focus to the upper window')
kh.map('n', '<leader>wc', '<cmd>close<CR>', kh.default_opts 'Close current window')
kh.map('n', '<leader>wo', '<C-w>o', kh.default_opts 'Close other windows')

kh.map('n', '<leader>tn', '<cmd>tabnew<CR>',      kh.default_opts 'New tab')
kh.map('n', '<leader>tc', '<cmd>tabclose<CR>',    kh.default_opts 'Close current tab')
kh.map('n', '<leader>to', '<cmd>tabonly<CR>',     kh.default_opts 'Close other tabs')
kh.map('n', '<leader>th', '<cmd>tabprevious<CR>', kh.default_opts 'Previous tab')
kh.map('n', '<leader>tl', '<cmd>tabnext<CR>',     kh.default_opts 'Next tab')
kh.map('n', '<leader>tm', '<cmd>-tabmove<CR>',    kh.default_opts 'Move tab left')
kh.map('n', '<leader>tM', '<cmd>+tabmove<CR>',    kh.default_opts 'Move tab right')

kh.map('n', '<leader>tt', '<cmd>split | terminal<CR>', kh.default_opts 'Enter to terminal mode')
kh.map('t', '<Esc><Esc>', '<cmd>q<CR>', kh.default_opts 'Exit from terminal mode')
kh.map('t', '<Esc>', '<C-\\><C-n>', kh.default_opts 'Go to normal mode from terminal mode')

