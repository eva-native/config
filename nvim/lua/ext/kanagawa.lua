local ok, kanagawa = pcall(require, 'kanagawa')

if not ok then
  vim.notify('error while loading kanagawa', vim.log.levels.ERROR)
  return
end

kanagawa.setup({
  compile = true,
  undercurl = true,                 -- Включить поддержку undercurl
  commentStyle = { italic = true }, -- Стиль комментариев
  functionStyle = {},
  keywordStyle = { italic = true }, -- Ключевые слова курсивом
  statementStyle = { bold = true }, -- Операторы жирным шрифтом
  typeStyle = {},
  transparent = true,               -- Прозрачный фон
  dimInactive = false,              -- Отключать неактивные окна
  terminalColors = true,            -- Поддержка цветов в терминале
  colors = {},
  theme = 'dragon',                 -- Load "wave" theme when 'background' option is not set
  background = {
    dark = 'wave',
    light = 'lotus',
  }
})

vim.cmd("colorscheme kanagawa")
