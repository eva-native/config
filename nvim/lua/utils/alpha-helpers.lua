local M = {}

function M.padding(val)
  return { type = 'padding', val = vim.F.if_nil(val, 1) }
end

function M.__get_default_mru_opts()
  if M.__default_mru_opts then return M.__default_mru_opts end

  M.__default_mru_opts = {
    items_number = 10,
    target_width = 35,
    autocd = false,
    ignore = nil,
    cwd = nil,
  }

  return M.__default_mru_opts
end

function M.__is_valid_file(file_path, opts)
  local utils = require('alpha.utils')

  if vim.fn.filereadable(file_path) == 0 then
    return false
  end

  local cwd_matches = not opts.cwd or vim.startswith(file_path, opts.cwd)
  if not cwd_matches then
    return false
  end

  local should_ignore = opts.ignore and opts.ignore(file_path, utils.get_extension(file_path))
  return not should_ignore
end

function M.__filter_recent_files(opts)
  local filtered = {}

  for _, file_path in pairs(vim.v.oldfiles) do
    if #filtered >= opts.items_number then break end

    if M.__is_valid_file(file_path, opts) then
      table.insert(filtered, file_path)
    end
  end

  return filtered
end

function M.__shorten_path(file_path, cwd, target_width)
  local plenary = require('plenary.path')
  local fnamem = vim.fn.fnamemodify

  local short_path = cwd and fnamem(file_path, ':.') or fnamem(file_path, ':~')

  if #short_path <= target_width then
    return short_path
  end

  short_path = plenary.new(short_path):shorten(1, {-2, -1})
  if #short_path <= target_width then
    return short_path
  end

  short_path = plenary.new(short_path):shorten(1, {-1})
  return short_path
end

function M.__get_file_icon(file)
  local utils = require('alpha.utils')
  local ico, hl = utils.get_file_icon(M.opts.file_icons.provider, file)

  if ico == '' then
    vim.notify('alpha: icon provider disabled file icons', vim.log.levels.WARN)
    return '', ''
  end

  return ico, hl
end

function M.__file_button(fn, sc, short_fn, opts)
  local dashboard = require('alpha.themes.dashboard')

  local cd_cmd = opts.autocd and ' | cd %:p:h' or ''
  local escaped_name = vim.fn.fnameescape(fn)

  local file_btn = dashboard.button(
    sc,
    short_fn,
    '<cmd>e ' .. escaped_name .. cd_cmd .. '<CR>'
  )

  return file_btn
end

function M.__create_file_buttons(files, start, opts)
  local buttons = {}

  local cwd = opts.cwd
  local target_width = opts.target_width

  for i, file_path in ipairs(files) do
    local display_name = M.__shorten_path(file_path, cwd, target_width)
    local shortcut = tostring(i + start - 1)

    buttons[i] = M.__file_button(file_path, shortcut, display_name, opts)
  end

  return buttons
end

function M.mru(start, opts)
  opts = vim.tbl_extend('force', M.__get_default_mru_opts(), opts or {})

  local filtered = M.__filter_recent_files(opts)
  local buttons = M.__create_file_buttons(filtered, start, opts)

  return {
    type = 'group',
    val = buttons,
    opts = { }
  }
end

function M.button(sc, txt, keybind, keybind_opts)
  return require('alpha.themes.dashboard').button(sc, txt, keybind, keybind_opts)
end

return M
