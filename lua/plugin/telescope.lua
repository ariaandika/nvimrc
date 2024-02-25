local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local set = vim.keymap.set
local desc = function(d) return { desc = d } end

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
