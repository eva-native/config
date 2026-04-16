return {
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build',
        config = function (plugin)
          local ok, err = pcall(require('telescope').load_extension, 'fzf')
          if ok then return end

          local util = require('utils')
          local lib = plugin.dir .. '/build/libfzf.' .. (util.is_windows() and 'dll' or 'so')

          if not vim.uv.fs_stat(lib) then
            vim.notify('telescope-fzf-native.nvim not build (' .. lib .. '). Rebuilding...', vim.log.levels.WARN)
            vim.fn.getchar()
            require('lazy').build({ plugins = { plugin }, show = false }):wait(function ()
              vim.notify('Rebuild telescope-fzf-native.nvim done. Please restart Neovim.')
            end)
          else
            vim.notify('Failed to load telescope-fzf-native:\n' .. err)
          end
        end
      }
    },
    keys = function ()
      local telescope = require('telescope.builtin')
      return {
        { '<leader>/', function ()
          telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            previewer = false, winblend = 10
          }))
        end, desc = 'FZF current buffer' },

        { '<leader>ff', telescope.find_files, desc = 'Find files (root)' },
        { '<leader>fr', telescope.oldfiles, desc = 'Recent' },

        { '<leader>sg', telescope.live_grep, desc = 'Grep (root)' },
      }
    end
  }
}
