return {
  { 'folke/lazy.nvim' },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('ext.kanagawa')
    end
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require('ext.alpha')
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('ext.neotree')
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function()
      require('ext.lualine')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('ext.telescope')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('ext.treesitter')
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('ext.autopairs')
    end
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
      'rcarriga/nvim-dap-ui',
      'p00f/clangd_extensions.nvim',
    },
    config = function()
      require('ext.mason-lsp')
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'windwp/nvim-autopairs',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
    },
    config = function()
      require('ext.cmp')
    end
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require('ext.conform')
    end
  },
  --  {
  --    'akinsho/bufferline.nvim',
  --    dependencies = { 'nvim-tree/nvim-web-devicons' },
  --    version = '*',
  --    config = function()
  --      require('ext.bufferline')
  --    end
  --  }
}
