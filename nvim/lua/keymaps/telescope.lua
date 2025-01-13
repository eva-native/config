local kh = require('keymaps.helpers')
local builtin = require('telescope.builtin')

kh.map('n', '<leader>ff', builtin.find_files, kh.default_opts '[F]ind [F]iles')
kh.map('n', '<leader>fk', builtin.keymaps, kh.default_opts '[F]ind [K]eymaps')
kh.map('n', '<leader>fh', builtin.help_tags, kh.default_opts '[F]ind [H]elp')
kh.map('n', '<leader>fs', builtin.builtin, kh.default_opts '[F]ind [S]elect telescope')
kh.map('n', '<leader>fw', builtin.grep_string, kh.default_opts '[F]ind current [W]ord')
kh.map('n', '<leader>fg', builtin.live_grep, kh.default_opts '[F]ind by [G]rep')
kh.map('n', '<leader>fd', builtin.diagnostics, kh.default_opts '[F]ind [D]iagnostics')
kh.map('n', '<leader>fr', builtin.resume, kh.default_opts '[F]ind [R]esume')
kh.map('n', '<leader>f.', builtin.oldfiles, kh.default_opts '[F]ind recent files ("." for repeat)')
kh.map('n', '<leader>fb', builtin.buffers, kh.default_opts '[F]ind existing [B]uffers')

kh.map('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, kh.default_opts '[/] Fuzzily search in current buffer')

kh.map('n', '<leader>f/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, kh.default_opts '[F]ind [/] in open files')

kh.map('n', '<leader>fn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, kh.default_opts '[F]ind [N]eovim files')

