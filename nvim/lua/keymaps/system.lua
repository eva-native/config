local km = vim.keymap
local opts = { noremap = true, silent = true }

km.set('n', '<left>', '<cmd>echo "Use \'h\' to move!!!"<CR>')
km.set('n', '<right>', '<cmd>echo "Use \'l\' to move!!!"<CR>')
km.set('n', '<down>', '<cmd>echo "Use \'j\' to move!!!"<CR>')
km.set('n', '<up>', '<cmd>echo "Use \'k\' to move!!!"<CR>')

km.set('n', '<leader>e', ':Neotree toggle<CR>', opts)

km.set('n', '<leader>ff', ':Telescope find_files<CR>', opts)    -- Поиск файлов
km.set('n', '<leader>fg', ':Telescope live_grep<CR>', opts)     -- Поиск текста в проектах
km.set('n', '<leader>fb', ':Telescope buffers<CR>', opts)       -- Открыть буферы
km.set('n', '<leader>fh', ':Telescope help_tags<CR>', opts)     -- Поиск по справочной документации
km.set('n', '<leader>fgc', ':Telescope git_commits<CR>', opts)  -- Поиск git коммитов
km.set('n', '<leader>fgb', ':Telescope git_branches<CR>', opts) -- Поиск git веток
km.set('n', '<leader>fr', ':Telescope oldfiles<CR>', opts)      -- Открыть недавно использованные файлы

km.set('n', '<C-h>', '<C-w>h', opts)
km.set('n', '<C-j>', '<C-w>j', opts)
km.set('n', '<C-k>', '<C-w>k', opts)
km.set('n', '<C-l>', '<C-w>l', opts)

km.set('n', '<leader>bn', ':bnext<CR>', opts)
km.set('n', '<leader>bp', ':bprevious<CR>', opts)
km.set('n', '<leader>bd', ':bdelete<CR>', opts)

km.set('n', '<A-j>', ':m .+1<CR>==', opts)
km.set('n', '<A-k>', ':m .-2<CR>==', opts)

km.set('n', '<leader>tn', ':tabnew<CR>', opts)
km.set('n', '<leader>to', ':tabonly<CR>', opts)
km.set('n', '<leader>tc', ':tabclose<CR>', opts)
km.set('n', '<leader>th', ':tabprevious<CR>', opts)
km.set('n', '<leader>tl', ':tabnext<CR>', opts)
km.set('n', '<leader>tm', ':-tabmove<CR>', opts) -- Переместить вкладку влево
km.set('n', '<leader>tM', ':+tabmove<CR>', opts) -- Переместить вкладку вправо

km.set('n', '<leader>/', ':noh<CR>', opts)

km.set('n', '<leader>tt', ':split | terminal<CR>', opts)  -- Открыть терминал внизу
km.set('n', '<leader>tv', ':vsplit | terminal<CR>', opts) -- Открыть терминал справа
km.set('t', '<Esc>', '<C-\\><C-n>', opts)                 -- Выйти из терминала в нормальный режим

km.set('n', '<leader>ws', ':split<CR>', opts)             -- Горизонтальный сплит
km.set('n', '<leader>wv', ':vsplit<CR>', opts)            -- Вертикальный сплит
km.set('n', '<leader>wc', ':close<CR>', opts)             -- Закрыть текущее окно
km.set('n', '<leader>wo', '<C-w>o', opts)                 -- Закрыть все окна кроме текущего
