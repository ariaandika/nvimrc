# Neovim Config

at higher level, config split into builtin config and plugins config

## Builtin

- `basemap.lua`, contains builtin keymaps
- `set.lua`, contain flags and commands
- `util.lua`, more advance functionality

## Plugins

this config does not use any plugin manager

every plugin is manually git cloned and pulled

updating plugins:

```bash
for i in `ls -1`; do (cd $i;git pull &); done
```

### `init.lua`

contain non-lsp plugins:

- `navarasu/onedark`, color theme
- `nvim-treesitter/nvim-treesitter`, treesitter
- `tpope/vim-fugitive`, git stuff
- `nvim-telescope/telescope`, fuzzyfinder
- `theprimeagen/harpoon`, pin file to a keybind
- `numToStr/Comment.nvim`, commenting
- `folke/todo-comments.nvim`, highlight todo marker
- `nvim-neo-tree/neo-tree.nvim`, file browser

### `lsp.lua`

contain lsp related plugins:

lsp can be turned off altogether with `LSP=0` env variable

especially rust lsp with `RUST_LSP=0` env variable

## Snippets

contains vscode style snippets via `luasnip.loaders.from_vscode` plugin

