local set = vim.keymap.set
local desc = function(d) return { desc = d } end
local so = function(id) vim.opt.rtp:append("~/.local/share/nvim/plugins/" .. id) end


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



so("nvim-treesitter")
require('nvim-treesitter.configs').setup({
    ensure_installed = { "javascript", "typescript", "svelte", "lua", "rust", "jsdoc", "json", "markdown" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})



so("plenary.nvim")
so("telescope.nvim")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
pcall(require('telescope').load_extension, 'fzf')
require("telescope").setup({
    defaults = {
        mappings = {
            i = { ["<esc>"] = actions.close },
        },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/{.git,node_modules}/*" },
        },
    },
})
set('n', '<tab>', builtin.buffers,            desc("Telescope: buffer"))
set('n', '<leader><tab>', builtin.find_files, desc("Telescope: all file"))
set('n', '<leader>fd', builtin.diagnostics,   desc("Telescope: diagnostic"))
set('n', '<leader>fp', builtin.builtin,       desc("Telescope: all builtin"))
set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end,  desc("Telescope: grep string"))



so("harpoon")
local harpoon = require("harpoon")
harpoon:setup()
set("n", "<leader>a", function() harpoon:list():add() end)
set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
set("n", "<M-q>", function() harpoon:list():select(1) end)
set("n", "<M-w>", function() harpoon:list():select(2) end)
set("n", "<M-e>", function() harpoon:list():select(3) end)
set("n", "<M-r>", function() harpoon:list():select(4) end)



so("Comment.nvim")
require('Comment').setup({
    toggler = { line = '<C-_>' },
    opleader = { line = '<C-_>' },
})

so("which-key.nvim")
require('which-key').setup({})
vim.o.timeout = true
vim.o.timeoutlen = 300

so("todo-comments.nvim")
require('todo-comments').setup({
    keywords = {
        ERROR = {
            color = "error",
        }
    }
})

so("nvim-web-devicons")
require'nvim-web-devicons'.setup({})

so("nvim-tree.lua")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({})
vim.keymap.set('n', '\\', '<C-w>w')
