local ok, ts = pcall(require, 'nvim-treesitter.configs')

if not ok then
  vim.notify('error while loading treesitter', vim.log.levels.ERROR)
  return
end

ts.setup({
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'dockerfile',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'vim',
    'vimdoc',
    'python',
  },
  modules = {},
  sync_install = false,
  auto_install = false,
  ignore_install = { },
  highlight = {
    enable = true,                             -- Включить подсветку синтаксиса через Tree-sitter
    additional_vim_regex_highlighting = false, -- Использовать только Tree-sitter
  },
  indent = { enable = true },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',    -- Начать выделение блока
      node_incremental = 'grn',  -- Расширить выделение
      scope_incremental = 'grc', -- Расширить по scope
      node_decremental = 'grm',  -- Уменьшить выделение
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer', -- Выделить всю функцию
        ['if'] = '@function.inner', -- Выделить тело функции
        ['ac'] = '@class.outer',    -- Выделить весь класс
        ['ic'] = '@class.inner',    -- Выделить тело класса
      },
    },
  },
})
