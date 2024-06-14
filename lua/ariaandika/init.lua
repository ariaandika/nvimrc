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



so("vim-fugitive")
set('n', '<leader>gs', vim.cmd.Git, desc("GitFugitive: git status"))
so("plenary.nvim")
so("telescope.nvim")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
pcall(require('telescope').load_extension, 'fzf')
require("telescope").setup({
    defaults = {
        preview = false,
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
        LATEST = {
            color = "error",
        },
        ERROR = {
            color = "error",
        }
    }
})


so("nvim-web-devicons")
require'nvim-web-devicons'.setup({})

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

