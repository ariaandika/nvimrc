vim.g.mapleader = " "

-- sensible defaults
vim.keymap.set('n', 'J', "J_")
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('n', 'G', "Gzz")

vim.keymap.set('v', '>', ">gv")
vim.keymap.set('v', '<', "<gv")
vim.keymap.set('v', '<Tab>', ">gv")
vim.keymap.set('v', '<S-Tab>', "<gv")

vim.keymap.set('n', 'zq', "@q")

-- navigation
vim.keymap.set({'n','v'}, '<PageUp>', '10<Up>', { noremap = true })
vim.keymap.set({'n','v'}, '<PageDown>', '10<Down>', { noremap = true })
vim.keymap.set({'n','v'}, '<S-Up>', '<Home>4<Up>', { noremap = true })
vim.keymap.set({'n','v'}, '<S-Down>', '<Home>4<Down>', { noremap = true })
vim.keymap.set({'n','v'}, '<C-Up>', '<Home>4<Up>', { noremap = true })
vim.keymap.set({'n','v'}, '<C-Down>', '<Home>4<Down>', { noremap = true })
vim.keymap.set('i', '<S-Up>', '<Up><Up><Up><Up>', { noremap = true })
vim.keymap.set('i', '<S-Down>', '<Down><Down><Down><Down>', { noremap = true })

-- util
vim.keymap.set('v', 'J', ":m '>+1<CR>gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv")
vim.keymap.set('n', '<M-Down>', "V:m '>+1<CR>")
vim.keymap.set('n', '<M-Up>', "V:m '<-2<CR>")
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv")
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv")

vim.keymap.set('i', '<M-d>', "<Esc><Esc>")
vim.keymap.set('i', '<M-Enter>', "<Esc><Esc>o")

vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('x', '<M-p>', "\"_dP")
vim.keymap.set('n', 'Q', "<leader>+y")

vim.keymap.set({'n','v'}, '<leader>y', "\"+y")
vim.keymap.set({'n','v'}, '<leader>Y', "\"+Y")

vim.keymap.set({'n','v'}, '<leader>d', "\"_d")

vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('v', '<leader>s', '"ry:%s/\\(<C-r>r\\)/<C-r>r/gI<Left><Left><Left>')
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>')
vim.keymap.set('n', '<leader>;', '<cmd>!bun run %<CR>')
