local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local set = vim.keymap.set
local desc = function(d) return { desc = d } end

set("n", "<leader>a", mark.add_file,        desc("Harpoon: add"))
set("n", "<leader>e", ui.toggle_quick_menu, desc("Harpoon: open window"))

-- ui.notification("oof")

set("n", "<M-q>", function() ui.nav_file(1) end, desc("Harpoon: switch 1"))
set("n", "<M-w>", function() ui.nav_file(2) end, desc("Harpoon: switch 2"))
set("n", "<M-e>", function() ui.nav_file(3) end, desc("Harpoon: switch 3"))
set("n", "<M-r>", function() ui.nav_file(4) end, desc("Harpoon: switch 4"))



