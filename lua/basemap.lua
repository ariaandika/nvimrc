local opt = { remap = false, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "\\", vim.cmd.Ex, opt) -- netrw

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<M-Down>', "V:m '>+1<CR>gv=")
vim.keymap.set('n', '<M-Up>', "V:m '<-2<CR>gv=")
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', "J_")
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('n', 'G', "Gzz")

vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('x', '<M-p>', "\"_dP")

vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")

vim.keymap.set('v', '>', ">gv")
vim.keymap.set('v', '<', "<gv")
vim.keymap.set('v', '<Tab>', ">gv")
vim.keymap.set('v', '<S-Tab>', "<gv")

vim.keymap.set('i', '<M-d>', "<Esc><Esc>")
vim.keymap.set('n', '<leader>f', ':%!./node_modules/.bin/prettier %<CR>', opt)
vim.keymap.set('i', '<M-Enter>', "<Esc><Esc>o")

vim.keymap.set('n', 'Q', "<nop>")
vim.keymap.set('n', 'zq', "@q")
-- vim.keymap.set('n', '<CR>', "o<Esc>")

vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('v', '<leader>s', '"ry:%s/\\(<C-r>r\\)/<C-r>r/gI<Left><Left><Left>')
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>')
vim.keymap.set('n', '<leader>;', '<cmd>!bun run %<CR>')
vim.keymap.set('n', '<leader>\\', '<cmd>Ex .<CR>')

vim.keymap.set({'n','v'}, '<PageUp>', '<C-u>', { noremap = true })
vim.keymap.set({'n','v'}, '<PageDown>', '<C-d>', { noremap = true })
vim.keymap.set({'n','v'}, '<S-Up>', '<C-u>', { noremap = true })
vim.keymap.set({'n','v'}, '<S-Down>', '<C-d>', { noremap = true })

-- ?    hover
-- '    code action
-- ;    diagnostic
-- gd   goto definition
-- <F2> rename
-- <leader>h  signature help
