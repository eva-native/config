require("helpers")
local neotree = require("neo-tree")

neotree.setup({
  close_if_last_window = true,
  name = {
    trailing_slash = true,
    use_git_status_colors = true,
    highlight = "NeoTreeFileName",
  },
  window = {
    width = 50,
  },
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
  icon = {
    folder_closed = "",
    folder_open = "",
    folder_empty = "",
    default = "*",
    highlight = "NeoTreeFileIcon"
  },
  git_status = {
    symbols = {
      -- Change type
      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
      deleted   = "✖",-- this can only be used in the git_status source
      renamed   = "",-- this can only be used in the git_status source
      -- Status type
      untracked = "",
      ignored   = "",
      unstaged  = "",
      staged    = "",
      conflict  = "",
    }
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        neotree.close_all()
      end
    }
  },
})

api.nvim_create_augroup("neotree", {})
api.nvim_create_autocmd("UiEnter", {
  desc = "Open Neotree automatically",
  group = "neotree",
  callback = function()
    if fn.argc() == 0 then
      cmd "Neotree position=current"
    end
  end,
})
