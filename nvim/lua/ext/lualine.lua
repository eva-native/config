local ok, lualine = pcall(require, 'lualine')

if not ok then
  vim.notify('error while loading neo-tree', vim.log.levels.ERROR)
  return
end

local config = {
  options = {
    theme = 'auto',
    icons_enable = true,
  },
  sections = {
    lualine_a = { 'mode' },                             -- Отображает текущий режим (NORMAL, INSERT и т.д.)
    lualine_b = { 'branch', 'diff', 'diagnostics' },    -- Ветка Git, статус файлов, диагностика LSP
    lualine_c = { 'filename' },                         -- Имя файла
    lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Кодировка, формат файла, тип
    lualine_y = { 'progress' },                         -- Прогресс (например, 45%)
    lualine_z = { 'location' },                         -- Позиция курсора (строка и столбец)
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' }, -- Для неактивных окон отображаем только имя файла
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},               -- Можно добавить настройки для линии вкладок
  extensions = { 'nvim-tree' }, -- Поддержка расширений, таких как nvim-tree
}

lualine.setup(config)
