return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build',
        config = function(plugin)
          local ok, err = pcall(require('telescope').load_extension, 'fzf')
          if ok then
            return
          end

          local os = require('utils.os')
          local lib = plugin.dir
            .. '/build/libfzf.'
            .. (os.is_windows() and 'dll' or 'so')

          if not vim.uv.fs_stat(lib) then
            vim.notify(
              'telescope-fzf-native.nvim not built ('
                .. lib
                .. '). Rebuilding...',
              vim.log.levels.WARN
            )
            require('lazy')
              .build({ plugins = { plugin }, show = false })
              :wait(function()
                vim.notify(
                  'Rebuild telescope-fzf-native.nvim done. Please restart Neovim.'
                )
              end)
          else
            vim.notify('Failed to load telescope-fzf-native:\n' .. err)
          end
        end,
      },
    },
    keys = {
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown({
              previewer = false,
              winblend = 10,
            })
          )
        end,
        desc = 'FZF current buffer',
      },

      --[[{
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find files (root)',
      },]]
      {
        '<leader>fr',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = 'Recent',
      },

      {
        '<leader>sg',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Grep (root)',
      },
    },
    {
      'dmtrKovalenko/fff.nvim',
      build = function()
        require('fff.download').download_or_build_binary()
      end,
      opts = {
        debug = {
          enabled = true,
          show_scores = true,
        },
      },
      lazy = false,
      keys = {
        {
          'ff',
          function()
            require('fff').find_files()
          end,
          desc = 'FFFind files',
        },
        {
          'fg',
          function()
            require('fff').live_grep()
          end,
          desc = 'LiFFFe grep',
        },
        {
          'fz',
          function()
            require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } })
          end,
          desc = 'Live fffuzy grep',
        },
        {
          'fc',
          function()
            require('fff').live_grep({ query = vim.fn.expand('<cword>') })
          end,
          desc = 'Search current word',
        },
      },
    },
  },
}
