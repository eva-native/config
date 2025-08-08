local M = {}

M.opts = {
  file_icons = {
    enable = true,
    highlight = true,
    provider = 'devicons',
  },
  mru = {
    ignore = function(path, ext)
      return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains({ 'gitcommit' }, ext))
    end,
    autocd = true,
  }
}

function M.padding(val)
  return { type = 'padding', val = val }
end

function M.icon(file)
  local utils = require('alpha.utils')

  if not M.opts.file_icons.enable then return '', '' end
  if not vim.tbl_contains({ 'devicons', 'mini' }, M.opts.file_icons.provider) then
    M.opts.file_icons.enable = false
    vim.notify('alpha: invalid icon provider: ' .. M.opts.file_icons.provider, vim.log.levels.WARN)
    return '', ''
  end

  local ico, hl = utils.get_file_icon(M.opts.file_icons.provider, file)
  if ico == '' then
    M.opts.file_icons.enable = false
    vim.notify('alpha: icon provider disable file icons', vim.log.levels.WARN)
  end
  return ico, hl
end

function M.highlight(ico, hl)
  if M.opts.file_icons.highlight and hl then
    return { hl, 0, #ico }
  end
end

function M.icon_text(fn)
  if not M.opts.file_icons.enable then return '', {} end

  local ico, hl = M.icon(fn)
  return ico..' ', { M.highlight(ico, hl) }
end

function M.button(sc, txt, keybind, keybind_opts)
  local dashboard = require('alpha.themes.dashboard')
  return dashboard.button(sc, txt, keybind, keybind_opts)
end

function M.file_button(fn, sc, short_fn, autocd)
  local dashboard = require('alpha.themes.dashboard')
  short_fn = short_fn or fn
  local ico_txt, highlight = M.icon_text(fn)

  local cd_cmd = (autocd and ' | cd %:p:h' or '')
  local file_btn = dashboard.button(sc, ico_txt .. short_fn, '<cmd>e ' .. vim.fn.fnameescape(fn) .. cd_cmd .. ' <CR>')
  local fn_start = short_fn:match('.*[/\\]')

  if fn_start ~= nil then
    table.insert(highlight, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_btn.opts.hl = highlight
  file_btn.opts.shrink_margin = true

  return file_btn
end

--- @param start number
--- @param cwd string? optional
--- @param items_number number? optional number of items to generate, default = 10
function M.mru(start, cwd, items_number)
  local utils = require('alpha.utils')
  local plenary = require('plenary.path')

  local opts = M.opts.mru
  items_number = vim.F.if_nil(items_number, 10)

  local old = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #old == items_number then break end
    local cwd_cond = not cwd or vim.startswith(v, cwd)
    local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
    if vim.fn.filereadable(v) == 1 and cwd_cond and not ignore then
      old[#old+1] = v
    end
  end

  local target_width = 35
  local tbl = {}

  for i, fn in ipairs(old) do
    local short_fn = (cwd and vim.fn.fnamemodify(fn, ':.')) or vim.fn.fnamemodify(fn, ':~')
    if #short_fn > target_width then
      short_fn = plenary.new(short_fn):shorten(1, {-2, -1})
      if #short_fn > target_width then
        short_fn = plenary.new(short_fn):shorten(1, {-1})
      end
    end

    local shortcut = tostring(i + start - 1)
    local file_btn = M.file_button(fn, shortcut, short_fn, opts.autocd)
    tbl[i] = file_btn
  end

  return {
    type = 'group',
    val = tbl,
    opts = {}
  }
end

return M
