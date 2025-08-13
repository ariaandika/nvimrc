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

-- ===== Neotree =====

so("nvim-web-devicons")
require("nvim-web-devicons").setup({
  strict = true,
  override_by_extension = {
    astro = {
      icon = "",
      color = "#EF8547",
      name = "astro",
    },
  },
})

-- vim.keymap.set('n', '\\', ':Ex<CR>', { silent = true })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

so("nui.nvim")
vim.keymap.set('n', '\\', ':Neotree float toggle reveal<CR>', { silent = true })
vim.keymap.set('n', '<leader>\\', ':Neotree current toggle reveal<CR>', { silent = true })
so("neo-tree.nvim")
require('neo-tree').setup({
  enable_diagnostics = false,
  enable_git_status = false,
  filesystem = {
    filtered_items = {
      hide_by_name = {
        "node_modules"
      },
      always_show = {
        ".env",
      },
    },
    hijack_netrw_behavior = "open_current"
  },
  default_component_configs = {
    file_size = {
      enabled = false,
    },
    type = {
      enabled = false,
    },
    last_modified = {
      enabled = false,
    },
    created = {
      enabled = false,
    },
  },
})

