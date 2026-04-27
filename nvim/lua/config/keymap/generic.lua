local map = vim.keymap.set

-- Self control
map('n', '<left>', '<cmd>echo "Use h to move!!!"<CR>', { desc = 'No arrows - use h' })
map('n', '<right>', '<cmd>echo "Use l to move!!!"<CR>', { desc = 'No arrows - use l' })
map('n', '<down>', '<cmd>echo "Use j to move!!!"<CR>', { desc = 'No arrows - use j' })
map('n', '<up>', '<cmd>echo "Use k to move!!!"<CR>', { desc = 'No arrows - use k' })

map('v', '<left>', '<Nop>', { desc = 'Disable left arrow' })
map('v', '<right>', '<Nop>', { desc = 'Disable right arrow' })
map('v', '<down>', '<Nop>', { desc = 'Disable down arrow' })
map('v', '<up>', '<Nop>', { desc = 'Disable up arrow' })

-- Window managment
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

map('t', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Go to right window' })

map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer managment
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all other buffers' })

-- Tab managment
map('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'Tab: New' })
map('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Tab: Close' })
map('n', '<leader>to', '<cmd>tabonly<CR>', { desc = 'Tab: Close Other Tabs' })

map('n', '<leader>tl', '<cmd>tabnext<CR>', { desc = 'Tab: Next' })
map('n', '<leader>th', '<cmd>tabprevious<CR>', { desc = 'Tab: Previous' })

for i = 1, 9 do
  map('n', '<leader>t' .. i, i .. 'gt', { desc = 'Tab: Go To Tab ' .. i })
end

map('n', '<leader>tm', '<cmd>tabmove<CR>', { desc = 'Tab: Move to end' })
map('n', '<leader>t<', '<cmd>-tabmove<CR>', { desc = 'Tab: Move Left' })
map('n', '<leader>t>', '<cmd>+tabmove<CR>', { desc = 'Tab: Move Right' })

map('n', '<leader>q', '<cmd>close<CR>', { desc = 'Close window' })
