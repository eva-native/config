# eva-native / config

> dotfiles by uzxenvy

Personal config for a nvim-first workflow. Linux is the primary target via Nix +
home-manager; everything also works standalone on macOS.

---

## What's inside

```
config/
├── nvim/         neovim config (lua, lazy.nvim)
├── tmux/         tmux.conf
├── alacritty/    alacritty.toml + kanagawa.toml
├── zsh/          zshrc + zshenv
├── git/          shared gitignore
├── aliasrc       portable shell aliases
├── flake.nix     home-manager flake
├── home.nix      home-manager module
└── resources/    wallpapers
```

---

## Install

### Nix (home-manager)

```sh
home-manager switch --flake .#uzxenvy
```

The flake pins nixpkgs unstable, home-manager, nixGL (for non-NixOS Linux), and
apple-fonts. `home.nix` installs packages, configures zsh + zplug + p10k, and
symlinks `nvim/`, `tmux/`, and `alacritty/` into `~/.config/`.

### Manual (macOS or any non-Nix system)

```sh
ln -s "$PWD/nvim"        ~/.config/nvim
ln -s "$PWD/tmux"        ~/.config/tmux
ln -s "$PWD/alacritty"   ~/.config/alacritty
ln -s "$PWD/zsh/zshrc"   ~/.zshrc
ln -s "$PWD/zsh/zshenv"  ~/.zshenv
ln -s "$PWD/aliasrc"     ~/.aliasrc
ln -s "$PWD/git/gitignore" ~/.gitignore
```

Required tools (Homebrew names):

```
neovim tmux alacritty zsh zplug
ripgrep fd fzf eza bat fastfetch
llvm stylua gopls pyright cmake-language-server
```

Plus a Nerd Font — the configs use **SF Mono Nerd Font** (or any Nerd Font you
prefer; edit `alacritty/alacritty.toml`).

---

## Neovim

Modern Neovim 0.11+ config. Around **30ms** cold startup on a warm cache.

### Layout

```
nvim/
├── init.lua
├── lua/config/
│   ├── options.lua         vim opts
│   ├── lazy.lua            bootstrap lazy.nvim
│   ├── lsp.lua             vim.lsp.config / vim.lsp.enable
│   └── keymap/
│       ├── generic.lua     non-LSP keymaps
│       └── lsp.lua         LspAttach buffer-local keymaps
├── lua/plugins/            lazy.nvim plugin specs (auto-imported)
└── lua/utils/              helpers
```

### Stack

| Area       | Plugin                              |
|------------|-------------------------------------|
| Manager    | lazy.nvim                           |
| Theme      | vscode.nvim (transparent)           |
| Dashboard  | alpha-nvim                          |
| Statusline | lualine.nvim                        |
| File tree  | neo-tree.nvim                       |
| Fuzzy      | telescope.nvim + fzf-native         |
| LSP        | nvim-lspconfig + mason-lspconfig    |
| Completion | nvim-cmp + LuaSnip + friendly-snippets |
| Treesitter | nvim-treesitter (`main` branch)     |
| Format     | conform.nvim                        |
| Debug      | nvim-dap + dap-ui + codelldb        |
| Pairs      | nvim-autopairs                      |
| Helper     | which-key.nvim                      |

### LSP servers

`lua_ls`, `clangd` (LLVM), `bashls`, `gopls`, `pyright`, `cmake-language-server`.

Mason auto-installs the ones it manages; `clangd` and `cmake-language-server`
come from system PATH (Homebrew LLVM and Homebrew respectively).

### Selected keymaps

Leader is **Space**.

```
Files / search
  <leader>ff      find files (telescope)
  <leader>fr      recent files
  <leader>sg      live grep
  <leader>/       fuzzy current buffer
  <leader>e       toggle neo-tree

LSP
  gd / gr / gI    definitions / references / implementations
  K               hover docs
  <leader>ca      code action
  <leader>cr      rename
  <leader>cf      format buffer
  <leader>ss/sS   document / workspace symbols
  <leader>sd/sD   document / workspace diagnostics

Buffers / windows / tabs
  <S-h> / <S-l>   prev / next buffer
  <leader>bd      delete buffer
  <leader>bo      close all other buffers
  <C-h/j/k/l>     window navigation
  <C-arrows>      resize window
  <leader>tn..tm  tab management
  <leader>q       close window

Debug
  <leader>db / dB  breakpoint / conditional breakpoint
  <leader>dr / dR  continue / restart
  <leader>ds/di/do step over / into / out
  <leader>du       toggle DAP UI
  <leader>dt       terminate

Etc.
  <leader>?        which-key (buffer-local)
  arrow keys       intentionally disabled — use hjkl
```

---

## Tmux

- Prefix: **C-Space** (replaces `C-b`)
- Vi mode keys (`v` to begin selection, `y` to yank)
- Alt-hjkl pane navigation
- C-hjkl pane resize
- Custom split bindings: `-` / `_` (vertical), `\` / `|` (horizontal)
- `M-,` / `M-.` for prev / next window
- Status bar: session name, host, uptime

---

## Alacritty

- Theme: **Kanagawa** (imported from `alacritty/kanagawa.toml`)
- Font: SF Mono Nerd Font Mono
- Window opacity: 0.85
- macOS-style Cmd-Q / Cmd-C / Cmd-V bindings

---

## Zsh

- Plugin manager: **zplug**
- Theme: **powerlevel10k**
- Plugins: `zsh-syntax-highlighting`, `zsh-autosuggestions`
- `fastfetch` runs at shell start
- Aliases: `v` = nvim, `ll`/`la`/`l` = eza variants, `tns` = `tmux new-session -As $USER`

---

## Wallpapers

`resources/` ships a small collection — Lain, Edgerunners, Hell's Paradise,
samurai art, and a few Japanese landscapes.
