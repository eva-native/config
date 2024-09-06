local M = {}

M.setup_lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  local mapping = {
    { 'n', 'gd',         '<cmd>Telescope lsp_definitions<CR>' },              -- Перейти к определению
    { 'n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>' },          -- Перейти к декларации
    { 'n', 'gr',         '<cmd>Telescope lsp_references<CR>' },               -- Найти ссылки на символ
    { 'n', 'gy',         '<cmd>Telescope lsp_type_definitions<CR>' },         -- Тип символа
    { 'n', 'gi',         '<cmd>Telescope lsp_implementations<CR>' },          -- Реализация
    { 'n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>' },                -- Всплывающая документация
    { 'n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>' },       -- Подсказка по параметрам
    { 'n', 'gl',         '<cmd>lua vim.diagnostic.open_float()<CR>' },        -- Диагностика (ошибки)
    { 'n', '[d',         '<cmd>lua vim.diagnostic.goto_prev()<CR>' },         -- Предыдущая ошибка
    { 'n', ']d',         '<cmd>lua vim.diagnostic.goto_next()<CR>' },         -- Следующая ошибка
    { 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>' },               -- Переименование символа
    { 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },          -- Действия кода (рефакторинг)
    { 'n', '<leader>f',  '<cmd>lua vim.lsp.buf.format { async = true }<CR>' }, -- Форматирование
  }

  for _, map in ipairs(mapping) do
    keymap(bufnr, map[1], map[2], map[3], opts)
  end
end

return M
