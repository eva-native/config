local alpha, dashboard = require('alpha'), require('alpha.themes.dashboard')
local utils = require('alpha.utils')
local plenary_ok, plenary_path = pcall(require, 'plenary.path')

if not plenary_ok then
  return
end

local if_nil = vim.F.if_nil

-- available: devicons, mini, to use nvim-web-devicons or mini.icons
-- if provider not loaded and enabled is true, it will try to use another provider
local file_icons = {
  enabled = true,
  highlight = true,
  provider = 'devicons'
}

local function padding(v)
  return { type = 'padding', val = v }
end

local function icon(fn)
  if file_icons.provider ~= 'devicons' and file_icons.provider ~= 'mini' then
    vim.notify('alpha: invalide file icons provider: ' .. file_icons.provider .. ', disable file icons', vim.log.levels.WARN)
    file_icons.enabled = false
    return '', ''
  end

  local ico, hl = utils.get_file_icon(file_icons.provider, fn)
  if ico == '' then
    file_icons.enabled = false
    vim.notify('alpha: mini or devicons get icon failed, disable file icons', vim.log.levels.WARN)
  end

  return ico, hl
end

local function file_button(fn, sc, short_fn, autocd)
  short_fn = short_fn or fn
  local ico_txt
  local fb_hl = {}

  if file_icons.enabled then
    local ico, hl = icon(fn)
    local hl_opts_type = type(file_icons.highlight)
    if hl_opts_type == 'boolean' then
      if hl and file_icons.highlight then
        table.insert(fb_hl, { hl, 0, #ico })
      end
    end
    if hl_opts_type == 'string' then
      table.insert(fb_hl, { file_icons.highlight, 0, #ico })
    end
    ico_txt = ico .. ' '
  else
    ico_txt = ''
  end

  local cd_cmd = (autocd and ' | cd %:p:h' or '')
  local file_btn = dashboard.button(sc, ico_txt .. short_fn, '<cmd>e ' .. vim.fn.fnameescape(fn) .. cd_cmd .. ' <CR>')
  local fn_start = short_fn:match('.*[/\\]')
  if fn_start ~= nil then
    table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_btn.opts.hl = fb_hl

  return file_btn
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
  -- autocd = true,
}

--- @param start number
--- @param cwd string? optional
--- @param items_number number? optional number of items to generate, default = 10
local function _mru(start, cwd, items_number)
  opts = opts or mru_opts
  items_number = if_nil(items_number, 10)

  local old_files = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #old_files == items_number then
      break
    end

    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end

    local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      old_files[#old_files+1] = v
    end
  end

  local target_width = 35
  local tbl = {}

  for i, fn in ipairs(old_files) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ":.")
    else
      short_fn = vim.fn.fnamemodify(fn, ":~")
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, {-2, -1})
      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, {-1})
      end
    end

    local shortcut = tostring(i + start - 1)
    local file_btn = file_button(fn, shortcut, short_fn, opts.autocd)
    tbl[i] = file_btn
  end

  return {
    type = 'group',
    val = tbl,
    opts = {},
  }
end

local header = {
  type = 'text',
  val = {
[[▄▀▀▄ ▄▀▀▄  ▄▀▀▀▀▄   ▄▀▀▄  ▄▀▄  ▄▀▀█▄▄▄▄  ▄▀▀▄ ▀▄  ▄▀▀▄ ▄▀▀▄  ▄▀▀▄ ▀▀▄ ]],
[[█   █    █ █     ▄▀ █    █   █ ▐  ▄▀   ▐ █  █ █ █ █   █    █ █   ▀▄ ▄▀]],
[[▐  █    █  ▐ ▄▄▀▀   ▐     ▀▄▀    █▄▄▄▄▄  ▐  █  ▀█ ▐  █    █  ▐     █  ]],
[[  █    █     █           ▄▀ █    █    ▌    █   █     █   ▄▀        █  ]],
[[   ▀▄▄▄▄▀     ▀▄▄▄▄▀    █  ▄▀   ▄▀▄▄▄▄   ▄▀   █       ▀▄▀        ▄▀   ]],
[[                  ▐   ▄▀  ▄▀    █    ▐   █    ▐                  █    ]],
[[                     █    ▐     ▐        ▐                       ▐    ]],
  },
  opts = {
    position = 'center',
    hl = 'Type',
  }
}

local mru = {
  type = 'group',
  val = {
    {
      type = 'text',
      val = 'recent files',
      opts = {
        position = 'center',
        hl = 'SpecialComment',
        shrink_margin = false,
      }
    },
    {
      type = 'group',
      val = function ()
        return { _mru(0, vim.fn.getcwd(), 5) }
      end,
      opts = { shrink_margin = false }
    }
  }
}

local buttons = {
  type = 'group',
  val = {
    { type = 'text', val = 'quick links', opts = { hl = 'SpecialComment', position = 'center' } },
    dashboard.button("e", "  New file", "<cmd>ene<CR>"),
    dashboard.button("SPC f f", "󰈞  Find file"),
    dashboard.button("SPC f g", "󰊄  Live grep"),
    dashboard.button("c", "  Configuration", "<cmd>execute 'cd' stdpath('config')<CR>"),
    dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
    dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
  },
  opts = {
    position = 'center',
  },
}

local footer = {
  type = 'text',
  val = {
-- [[⡀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⢻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠤⠤⠴⢶⣶⡶⠶⠤⠤⢤⣀⡀⠀⠀⠂⠀⠀⠠⠀⠀⠀⠀⠀⠀⢀⣠⣾⠁]],
-- [[⠀⠻⣯⡗⢶⣶⣶⣶⣶⢶⣤⣄⣀⣀⡤⠒⠋⠁⠀⠀⠀⠀⠚⢯⠟⠂⠀⠀⠀⠀⠉⠙⠲⣤⣠⡴⠖⣶⣶⡲⣶⣿⡟⢩⡴⠃⠀]],
-- [[⠀⠀⠈⠻⠾⣿⣿⣬⣿⣾⡏⢹⣏⠉⠢⣄⣀⣀⠤⠔⠒⠊⠉⠉⠉⠉⠑⠒⠀⠤⣀⡠⠚⠉⣹⣧⣝⣿⣿⣷⠿⠿⠛⠉⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠈⣹⠟⠛⠿⣿⣤⡀⣸⠿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠾⣇⢰⣶⣿⠟⠋⠋⠳⡄⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⢠⡞⠁⠀⠀⡠⢾⣿⣿⣯⠀⠈⢧⡀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠁⢀⣿⣿⣯⢼⠓⢄⠂⢀⡘⣦⡀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⣰⣟⣟⣿⣀⠎⠀⠀⢳⠘⣿⣷⡀⢸⣿⣶⣤⣄⣀⣤⢤⣶⣿⡇⢀⣾⣿⠋⢀⡎⠀⠀⠳⣤⢿⠿⢷⡀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⣰⠋⠀⠘⣡⠃⠀⠀⠀⠈⢇⢹⣿⣿⡾⣿⣻⣖⠛⠉⠁⣠⠏⣿⡿⣿⣿⡏⠀⡼⠀⠀⠀⠁⠘⢆⠀⠀⢹⡄⠀⠀⠀]],
-- [[⠀⠀⠀⢰⠇⠀⠀⣰⠃⠀⠀⣀⣀⣀⣼⢿⣿⡏⡰⠋⠉⢻⠳⣤⠞⡟⠀⠈⢣⡘⣿⡿⠶⡧⠤⠄⣀⣁⠀⠈⢆⠀⠀⢳⠀⠀⠀]],
-- [[⠀⠀⠀⡟⠀⠀⢠⣧⣴⣊⣩⢔⣠⠞⢁⣾⡿⢹⣷⠋⠀⣸⡞⠉⢹⣧⡀⠐⢃⢡⢹⣿⣆⠈⠢⣔⣦⣬⣽⣶⣼⣄⠀⠈⣇⠀⠀]],
-- [[⠀⠀⢸⠃⠀⠘⡿⢿⣿⣿⣿⣛⣳⣶⣿⡟⣵⠸⣿⢠⡾⠥⢿⡤⣼⠶⠿⡶⢺⡟⣸⢹⣿⣿⣾⣯⢭⣽⣿⠿⠛⠎⠀⠀⢹⠀⠀]],
-- [[⠀⠀⢸⠀⠀⠀⡇⠀⠈⠙⠻⠿⣿⣿⣿⣇⣸⣧⣿⣦⡀⠀⣘⣷⠇⠀⠄⣠⣾⣿⣯⣜⣿⣿⡾⠿⠛⠉⠀⠀⠀⢸⠀⠀⢸⡆⠀]],
-- [[⠀⠀⢸⠀⠀⠀⡇⠀⠀⠀⠀⣀⠼⠋⢹⣿⣿⣿⡿⣿⣿⣧⡴⠛⠀⢴⣿⢿⡟⣿⣿⣿⡿⠀⠙⠲⣬⡀⠀⠀⠀⢸⣀⠀⢸⡇⠀]],
-- [[⠀⠀⢸⣀⣷⣾⣇⠀⣠⠴⠋⠁⠀⠀⣿⣿⡛⣿⡇⢻⡿⢟⠁⠀⠀⢸⠿⣼⡃⣿⣿⣿⡿⣇⣁⣁⣆⣉⣓⣮⣀⣹⣿⣿⣼⠁⠀]],
-- [[⠀⠀⠸⡏⠙⠁⢹⠋⠉⠉⠉⠉⠉⠙⢿⣿⣅⠀⢿⡿⠦⠀⠁⠀⢰⡃⠰⠺⣿⠏⢀⣽⣿⡛⠉⢩⠉⠀⠈⠁⢈⡇⠈⠇⣼⠀⠀]],
-- [[⠀⠀⠀⢳⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠈⢿⣿⣷⣌⠧⡀⢲⠄⠀⠀⢴⠃⢠⢋⣴⣿⣿⠏⠀⠀⡇⠀⠀⠀⠀⡸⠀⠀⢠⠇⠀⠀]],
-- [[⠀⠀⠀⠈⢧⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣧⠐⠸⡄⢠⠀⢸⠀⢠⣿⣟⡿⠋⠀⠀⠀⡅⠀⠀⠀⡰⠁⠀⢀⡟⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠈⢧⠀⠀⠀⠣⡀⠀⠀⠀⠀⠀⠀⠈⠛⢿⡇⢰⠁⠸⠄⢸⠀⣾⠟⠉⠀⠀⠀⠀⠀⠀⠀⢀⠜⠁⠀⢀⡞⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠙⢄⠀⠀⠀⠀⠀⠀⠀⢨⡷⣜⠀⠀⠀⠘⣆⢻⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⠀⠀⣠⠎⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀⠑⠦⣀⠀⠀⠀⠀⠈⣷⣿⣦⣤⣤⣾⣿⢾⠀⠀⠀⠀⠀⣀⠴⠋⠀⠀⢀⡴⠃⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢄⡀⢸⣶⣿⡑⠂⠤⣀⡀⠱⣉⠻⣏⣹⠛⣡⠏⢀⣀⠤⠔⢺⡧⣆⠀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⢽⡁⠀⠀⠀⠀⠈⠉⠙⣿⠿⢿⢿⠍⠉⠀⠀⠀⠀⠉⣻⡯⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠲⠤⣀⣀⡀⠀⠈⣽⡟⣼⠀⣀⣀⣠⠤⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⢻⡏⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣤⠤⠤⢤⣤⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠶⠚⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠓⠲⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⢀⡴⣏⠁⠀⡀⠀⠀⠀⠀⠀⢀⣀⣠⡤⠤⠤⠤⠤⠤⣤⣀⣀⠀⠀⠀⠀⠀⣠⣄⠀⠙⠷⣄⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⢀⡴⠋⠀⢸⡟⠋⢻⠀⢀⡤⠖⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠳⢦⣀⠀⠨⠛⠀⠀⠀⠈⢳⣄⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⣠⠟⠀⠀⠀⠚⠁⢀⡼⢿⣍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣬⡟⢦⣄⠀⠀⠀⠀⠀⠙⢦⠀⠀⠀⠀]],
[[⠀⠀⠀⣴⠃⠀⠀⠀⠀⢀⡴⠋⠀⠈⣿⣟⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢖⣽⣿⠁⠀⠈⢳⡄⠀⠀⠀⠀⠈⢳⡀⠀⠀]],
[[⠀⠀⡼⠁⠀⠀⠀⠀⢠⠞⠁⠀⠀⠀⢹⣷⣿⡾⣷⣦⣀⠀⠀⠀⠀⠀⠀⣠⣴⣿⢟⣿⣿⠇⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⢳⡀⠀]],
[[⠀⣸⠃⠀⠀⠀⠀⢰⠏⠀⠀⠀⠀⠀⠀⢧⠹⡷⢭⡟⢿⣷⣤⡀⢀⡴⣾⠿⢙⠜⢫⠏⡞⠀⠀⠀⠀⠀⠀⠘⢧⠀⠀⠀⠀⠀⢷⠀]],
[[⠀⡏⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠈⣇⠘⣦⠙⢮⣼⡷⣟⢷⣾⣹⠖⠁⣰⠃⣸⠁⠀⠀⠀⠀⠀⠀⠀⠘⣧⠀⠀⠀⠀⠘⡆]],
[[⢸⠀⠀⠀⠀⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠘⣧⢶⠻⢄⠉⠉⢛⠟⢦⣴⡃⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⢇]],
[[⣼⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣷⢋⡿⠘⢦⠀⢱⡴⠋⢀⠎⢸⣟⣾⣄⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⡇⠀⠀⠀⠀⢸]],
[[⣿⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⢀⡴⠊⣁⣼⣿⡅⢸⣄⠑⣄⡇⡔⢁⡴⠀⢹⠧⣌⣑⢦⡀⠀⠀⠀⠀⠀⠣⠀⡇⠀⠀⠀⠀⢸]],
[[⢿⠀⠀⠀⠀⠘⡇⠀⠀⠀⢀⡠⣶⠟⣛⣩⠥⢴⣿⣇⠘⣿⣿⡿⠀⣿⣿⡿⢰⣿⠢⠤⠭⠿⣿⣷⢤⡀⠀⠀⢘⠀⡇⠀⠀⠀⠀⢸]],
[[⢸⠀⠀⡀⡀⠀⢷⠀⣠⣴⣭⣞⣁⣭⡼⠷⠷⠟⠉⢻⣦⠈⢛⠁⠀⡝⠋⡴⡿⠈⠛⠷⠷⠶⡴⣮⡷⣬⣲⣄⢰⢸⠃⣀⣀⠀⠀⡞]],
[[⠈⣇⠈⠛⡏⠀⠸⣟⠛⠛⠓⠒⠒⠒⠒⠒⠒⠒⠒⠚⣿⡗⢺⠒⠒⡗⢺⣷⠓⠒⠒⠒⠒⠒⠒⠒⠒⠚⠛⠚⢛⡟⠀⠙⡿⠀⢠⠇]],
[[⠀⢹⡄⠰⣧⠀⠀⠹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⣌⠀⠀⢣⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠃⠀⡼⠀]],
[[⠀⠀⢳⡀⠹⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣶⢰⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡞⠁⠀⠀⠀⠀⣼⠃⠀]],
[[⠀⠀⠀⢻⡄⠀⠀⠀⠀⠈⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡍⢉⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠄⠀⠀⢀⡼⠃⠀⠀]],
[[⠀⠀⠀⠀⠹⣆⠀⠀⠀⠀⠀⠙⠳⣄⡀⠀⠀⠀⠀⠀⠀⠀⢹⡷⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠋⠁⠀⠀⠀⠀⢠⡞⠁⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠈⢷⣄⠀⠀⠀⠀⠀⠀⠙⠲⢤⣀⠀⠀⠀⠀⠀⢣⡸⠀⠀⠀⠀⠀⢀⣠⠴⠚⠁⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠈⠉⠓⠒⠶⠤⠼⠧⠤⠶⠖⠒⠋⠉⠀⠀⠀⠀⠀⠀⠀⣀⡴⠋⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⣤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⠦⣄⣀⡀⠀⠀⠀⠈⠉⠀⠟⠀⠀⠀⠀⣀⣀⠤⠖⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠓⠒⠒⠒⠒⠒⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  },
  opts = {
    position = 'center',
    hl = 'Type',
  }
}

local config = {
  layout = {
    padding(1),
    header,
    padding(1),
    mru,
    padding(1),
    buttons,
    -- padding(1),
    footer,
  },
  opts = {
    margin = 5,
    setup = function ()
      vim.api.nvim_create_autocmd('DirChanged', {
        pattern = '*',
        group = vim.api.nvim_create_augroup('uzxalpha', {}),
        callback = function ()
          alpha.redraw()
          vim.cmd('AlphaRemap')
        end,
      })
    end,
  }
}

alpha.setup(config)

