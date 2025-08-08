return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  opts = { },
  config = function(_, opts)
    local au = require('util.alpha')
    local header = {
      type = 'text',
      val = {
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠴⠒⠒⠒⠒⠢⠤⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣠⠞⠁⠀⠚⠋⢀⣠⡤⠤⠤⢤⣟⠲⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⢀⡞⢩⡖⠛⡾⠁⠀⠀⠀⡠⠊⠁⠀⠀⢰⣶⣶⡄⠙⢮⡙⢗⡄⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⢸⡅⢻⡀⡼⠁⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠻⡈⡇⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠳⣄⠉⠁⠀⠀⠀⢸⠁⠀⣀⠤⠖⠊⠉⠉⠉⠉⠒⢦⡀⠃⢸⡀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⠀⢸⡴⠋⠀⠀⢀⠀⠀⠀⠀⡀⠀⠀⠙⢿⡀⢣⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢀⡼⠁⠀⢠⡇⠀⣿⠛⢿⡄⠀⣇⣆⠀⡆⠀⢹⣼⡄⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⣸⠃⢢⣷⣸⡇⣀⢿⠀⢸⣇⡀⣹⣼⡀⠰⠀⢘⣿⡇⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⢸⡇⠀⢀⡏⢀⠾⠴⢟⡛⣟⠛⠀⣸⠙⠈⣷⡟⠺⢿⣾⠾⣿⠁⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⢸⠃⠀⢸⢳⢾⡀⠰⣹⣿⠏⠀⠀⠀⠀⠀⢻⣿⣷⢬⣿⣴⠿⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⡜⠀⠀⡞⠻⡇⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⣼⠏⠙⡄⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⢰⠃⢀⣼⣆⠀⣙⣦⠀⠀⠀⠀⠀⠀⠤⠀⠀⠀⠀⣰⢻⠀⠀⣿⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⢀⡇⢀⠎⠘⠀⠑⠏⠋⠙⢤⡀⠀⠀⠠⠦⠀⢀⡤⢾⠃⢸⠀⠀⠰⣇⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠘⣇⡇⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢶⣶⣶⠚⠉⠀⢸⠀⢠⠀⠀⠀⠙⣆⠀⠀⠀]],
        [[⠀⠀⠀⢀⡾⠛⡇⠀⠀⠀⠀⠀⠀⠀⣠⠔⠊⢁⣿⣿⠓⠠⣄⡈⡀⢸⠀⠀⠀⠀⢸⠀⠀⠀]],
        [[⠀⠀⢀⡞⠁⠀⠘⠢⡀⠀⠀⣠⡔⠋⠀⡠⠀⢸⠉⠁⠀⠠⠀⠉⠃⢸⠀⠀⢀⣴⡁⠀⠀⠀]],
        [[⠀⠀⡼⠀⠀⠀⠀⠘⠈⠁⠉⠉⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠐⠄⡇⢸⠉⠉⠁⠀⢱⡄⠀⠀]],
        [[⠀⣼⠁⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⢠⢦⠀⠀⠀⣧⠃⠀⠀⠀⠇⠀⢳⠀⠀]],
        [[⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠘⠛⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⢸⡇⠀]],
        [[⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠈⡇⠀]],
        [[⢸⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀]],
        [[⠈⡆⠀⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣴⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇]],
        [[]],
        [[ 𝙻𝚎𝚝'𝚜 𝚊𝚕𝚕 𝚕𝚘𝚟𝚎 𝙻𝚊𝚒𝚗 ]],
        [[ 𝙻𝚎𝚝'𝚜 𝚊𝚕𝚕 𝚕𝚘𝚟𝚎 𝙻𝚊𝚒𝚗 ]],
        [[ 𝙻𝚎𝚝'𝚜 𝚊𝚕𝚕 𝚕𝚘𝚟𝚎 𝙻𝚊𝚒𝚗 ]],
        [[                 𝙻𝚊𝚒𝚗 ]],
        [[                  𝙻𝚊𝚒𝚗 ]],
        [[                   𝙻𝚊𝚒𝚗 ]],
        [[                    𝙻𝚊𝚒𝚗 ]],
        [[                     𝙻𝚊𝚒𝚗 ]],
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
            return { au.mru(0, vim.fn.getcwd(), 10) }
          end,
          opts = { shrink_margin = false }
        }
      }
    }
    local buttons = {
      type = 'group',
      val = {
        { type = 'text', val = 'quick links', opts = { hl = 'SpecialComment', position = 'center' } },
        au.button("e", "  New file", "<cmd>ene<CR>"),
        au.button("SPC f f", "󰈞  Find file"),
        au.button("SPC f g", "󰊄  Live grep"),
        au.button("c", "  Configuration", "<cmd>execute 'cd' stdpath('config')<CR>"),
        au.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
        au.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      },
      opts = {
        position = 'center',
      },
    }
    local footer = {
      type = 'text',
      val = { [[made by uzxenvy (eva-native)]] },
      opts = {
        position = 'center',
        hl = 'Type',
      }
    }
    require('alpha').setup({
      layout = {
        au.padding(1),
        header,
        au.padding(1),
        mru,
        au.padding(1),
        buttons,
        au.padding(1),
        footer,
      }
    })
  end
}
