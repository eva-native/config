return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
      theme = 'dragon',
      background = {
        dark = 'dragon',
        light = 'lotus'
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd 'colorscheme kanagawa'
    end
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('ext.alpha')
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '.git'
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute({ action = 'close' })
          end
        },
      }
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)
      require('keymaps.neo-tree')
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      options = {
        theme = 'auto',
        icons_enable = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { 'nvim-tree' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    opts = {
      extensions = {
        ['ui-select'] = {
          -- require('telescope.themes').get_dropdown(),
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      require('keymaps.telescope')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'lua', 'bash', 'c', 'cpp', 'cmake', 'go', 'dockerfile', 'javascript', 'json', 'vim', 'vimdoc', 'rust', 'elixir', 'python' },
      auto_install = true,
      modules = {},
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
    opts = {
      max_concurrent_installers = 10,
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'p00f/clangd_extensions.nvim',
    },
    config = function()
      require('ext.lsp')
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      {'leoluz/nvim-dap-go', config = true},
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      require('keymaps.dap').setup(dap, dapui)
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end,
        config = function()
          require('luasnip').setup()
          require('luasnip.loaders.from_lua').lazy_load {
            paths = vim.fn.stdpath('config')..'/lua/snippets'
          }
        end
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      require('ext.cmp')
    end
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    event = 'BufRead',
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
    config = function(_, opts)
      local hop = require('hop')
      hop.setup(opts)
      require('keymaps.hop').setup(hop)
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
  }
}
