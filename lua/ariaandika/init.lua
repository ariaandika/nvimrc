local set = vim.keymap.set
local desc = function(d) return { desc = d } end
local so = function(id) vim.opt.rtp:append(PLUGIN_SRC .. id) end

-- ===== OneDark Theme =====

so("onedark.nvim")
local c = require("onedark.palette")
require('onedark').setup({
  style = 'dark',
  transparent = true,
  highlights = {
    ["@parameter"] = {fmt = 'italic,bold'},
    ["@parameter.reference"] = {fg = c.dark.red},
  },
  code_style = { comments = 'bold' }
})
require('onedark').load()

-- ===== Treesitter =====

so("nvim-treesitter")
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "javascript", "typescript", "svelte", "lua", "rust", "jsdoc", "json", "markdown"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
})

vim.treesitter.language.register("markdown", "mdx")

-- ===== Git Fugitive =====

so("vim-fugitive")
set('n', '<leader>gs', vim.cmd.Git, desc("GitFugitive: git status"))

-- ===== Harpoon =====

so("harpoon")
local harpoon = require("harpoon")
harpoon:setup()
set("n", "<leader>a", function() harpoon:list():add() end)
set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
set("n", "<M-q>", function() harpoon:list():select(1) end)
set("n", "<M-w>", function() harpoon:list():select(2) end)
set("n", "<M-e>", function() harpoon:list():select(3) end)
set("n", "<M-r>", function() harpoon:list():select(4) end)

-- ===== Oil =====

so("oil.nvim")
require("oil").setup()
set("n", "\\", ":Oil<CR>", desc("Oil: Oil nvim"))

-- ===== Comment =====

so("Comment.nvim")
require('Comment').setup({
  toggler = { line = '<C-_>' },
  opleader = { line = '<C-_>', block = '<leader>gb' },
})

-- ===== Todo Comment =====

so("todo-comments.nvim")
require('todo-comments').setup({
  keywords = {
    LATEST = { color = "error", },
    FEAT = { color = "info", },
    ERROR = { color = "error", }
  }
})

-- ===== Icons =====

so("nvim-web-devicons")
require("nvim-web-devicons").setup({
  strict = true,
})

