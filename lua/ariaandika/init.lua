-- ONEDARK
-- TREESITTER

local set = vim.keymap.set
local desc = function(d) return { desc = d } end


vim.opt.rtp:prepend("~/.local/share/nvim/lazy/onedark.nvim")
local c = require("onedark.palette")
require('onedark').setup {
    style = 'dark',
    transparent = true,
    highlights = {
        ["@parameter"] = {fmt = 'italic,bold'},
        ["@parameter.reference"] = {fg = c.dark.red},
    },
    code_style = {
        comments = 'bold',
        -- keywords = 'none',
        -- functions = 'none',
        -- strings = 'none',
        -- variables = 'none'
    },
}
require('onedark').load()



vim.opt.rtp:prepend("~/.local/share/nvim/lazy/nvim-treesitter")
require('nvim-treesitter.configs').setup({
    ensure_installed = { "javascript", "typescript", "svelte", "lua", "rust", "jsdoc", "json", "markdown" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})






vim.opt.rtp:prepend("~/.local/share/nvim/lazy/plenary.nvim")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/telescope.nvim")
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

-- builtin.quickfix
-- builtin.commands
-- builtin.git_status

-- Layout Mode
-- themes.get_dropdow
-- theme = cursor
-- themes.get_ivy

set('n', '<tab>', builtin.buffers,            desc("Telescope: buffer"))
set('n', '<leader><tab>', builtin.find_files, desc("Telescope: all file"))
set('n', '<leader>fd', builtin.diagnostics,   desc("Telescope: diagnostic"))
set('n', '<leader>fp', builtin.builtin,       desc("Telescope: all builtin"))
set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end,  desc("Telescope: grep string"))






-- vim.opt.rtp:prepend("~/.local/share/nvim/lazy/harpoon")
-- local mark = require('harpoon.mark')
-- local ui = require('harpoon.ui')
-- set("n", "<leader>a", mark.add_file,             desc("Harpoon: add"))
-- set("n", "<leader>e", ui.toggle_quick_menu,      desc("Harpoon: open window"))
-- set("n", "<M-q>", function() ui.nav_file(1) end, desc("Harpoon: switch 1"))
-- set("n", "<M-w>", function() ui.nav_file(2) end, desc("Harpoon: switch 2"))
-- set("n", "<M-e>", function() ui.nav_file(3) end, desc("Harpoon: switch 3"))
-- set("n", "<M-r>", function() ui.nav_file(4) end, desc("Harpoon: switch 4"))

-- HARPOON2
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/harpoon")
local harpoon = require("harpoon")
harpoon:setup()
set("n", "<leader>a", function() harpoon:list():append() end)
set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
set("n", "<M-q>", function() harpoon:list():select(1) end)
set("n", "<M-w>", function() harpoon:list():select(2) end)
set("n", "<M-e>", function() harpoon:list():select(3) end)
set("n", "<M-r>", function() harpoon:list():select(4) end)





vim.opt.rtp:prepend("~/.local/share/nvim/lazy/Comment.nvim")
require('Comment').setup({
    toggler = { line = '<C-_>' },
    opleader = { line = '<C-_>' },
})

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/which-key.nvim")
require('which-key').setup({ })
vim.o.timeout = true
vim.o.timeoutlen = 300


vim.opt.rtp:prepend("~/.local/share/nvim/lazy/outline.nvim")
set("n", "<leader>o", "<cmd>Outline<CR>", desc("Outline: toggle"))
require("outline").setup({})

