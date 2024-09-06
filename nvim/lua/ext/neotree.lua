local ok, neotree = pcall(require, 'neo-tree')

if not ok then
  vim.notify('error while loading neo-tree', vim.log.levels.ERROR)
  return
end

local config = {
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        ".git"
      },
    },
    hijack_netrw_behavior = "open_current",
    follow_current_file = {
      enabled = true,
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  }
}

neotree.setup(config)
-- vim.api.nvim_create_augroup("neotree", {})
-- vim.api.nvim_create_autocmd("UiEnter", {
--   desc = "Open Neotree automatically",
--   group = "neotree",
--   callback = function()
--     if vim.fn.argc() == 0 then
--       vim.cmd "Neotree position=current"
--     end
--   end,
-- })
