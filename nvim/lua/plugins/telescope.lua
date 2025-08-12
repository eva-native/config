local util = require('util')

return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build',
        config = function (plugin)
          local ok, err = pcall(require('telescope').load_extension, 'fzf')
          if ok then return end
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
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = function()
      local telescope = require('telescope.builtin')
      return {
        { '<leader>/', function()
          telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10, previewer = false
          }))
        end, desc = 'FZF current buffer' },

        { '<leader>ff', telescope.find_files, desc = 'Find files (root)' },
        { '<leader>fg', telescope.git_files, desc = 'Find files (git)' },
        { '<leader>fb', function() telescope.buffers({ sort_mru = true, }) end, desc = 'Buffers' },
        { '<leader>fr', telescope.oldfiles, desc = 'Recent' },

        { '<leader>sg', telescope.live_grep, desc = 'Grep (root)' },
        { '<leader>sk', telescope.keymaps, desc = 'Key maps' },

        { '<leader>ss', telescope.lsp_document_symbols, desc = 'Goto symbol' },
        { '<leader>sS', telescope.lsp_dynamic_workspace_symbols, desc = 'Goto symbol (workspace)' },
        { '<leader>sD', telescope.diagnostics, desc = 'Workspace diagnostics' },
        { '<leader>sd', function() telescope.diagnostics({bufnr = 0}) end, desc = 'Document diagnostics' },

        { '<leader>gc', telescope.git_commits, desc = 'Git commits' },
        { '<leader>gs', telescope.git_status, desc = 'Git status' },
      }
    end,
  },
}
