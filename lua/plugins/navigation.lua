local set = vim.keymap.set
local desc = function(d) return { desc = d } end

return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            -- local actions = require("telescope.actions")

            -- pcall(require('telescope').load_extension, 'fzf')

            -- require("telescope").setup({
            --     defaults = {
            --         mappings = {
            --             i = { ["<esc>"] = actions.close },
            --         },
            --     },
            --     pickers = {
            --         find_files = {
            --             find_command = { "rg", "--files", "--hidden", "--glob", "!**/{.git,node_modules}/*" },
            --         },
            --     },
            -- })

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
        end
    },
    {
        'theprimeagen/harpoon',
        lazy = false,
        config = function()
            -- local mark = require('harpoon.mark')
            -- local ui = require('harpoon.ui')
            --
            -- set("n", "<leader>a", mark.add_file,        desc("Harpoon: add"))
            -- set("n", "<leader>e", ui.toggle_quick_menu, desc("Harpoon: open window"))
            --
            -- set("n", "<M-q>", function() ui.nav_file(1) end, desc("Harpoon: switch 1"))
            -- set("n", "<M-w>", function() ui.nav_file(2) end, desc("Harpoon: switch 2"))
            -- set("n", "<M-e>", function() ui.nav_file(3) end, desc("Harpoon: switch 3"))
            -- set("n", "<M-r>", function() ui.nav_file(4) end, desc("Harpoon: switch 4"))

            -- HARPOON2
            local harpoon = require("harpoon")
            harpoon:setup()
            set("n", "<leader>a", function() harpoon:list():append() end)
            set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            set("n", "<M-q>", function() harpoon:list():select(1) end)
            set("n", "<M-w>", function() harpoon:list():select(2) end)
            set("n", "<M-e>", function() harpoon:list():select(3) end)
            set("n", "<M-r>", function() harpoon:list():select(4) end)
        end
    },
    -- {
    --     'ms-jpq/chadtree',
    --     config = function()
    --         local chadtree_settings = {
    --
    --         }
    --         vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
    --     end
    -- },
}
