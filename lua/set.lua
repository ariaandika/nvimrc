local g = vim.g

g.shiftwidth = 4

vim.cmd[[command W write]]
vim.cmd[[command Wa wall]]
vim.cmd[[command WA wall]]
vim.cmd[[command Wq wq]]
vim.cmd[[command Q q]]

vim.api.nvim_exec([[
  autocmd InsertEnter * inoremap { {}<Esc>i
  autocmd InsertEnter * inoremap ( ()<Esc>i
  autocmd InsertEnter * inoremap [ []<Esc>i
  autocmd InsertEnter * inoremap " ""<Esc>i
  autocmd InsertEnter * inoremap ' ''<Esc>i
  autocmd InsertEnter * inoremap < <><Esc>i
]], false)

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.timeout = false

vim.opt.shiftwidth = 4          -- when use "<" or ">"
vim.opt.expandtab = true        -- use spaces by default
vim.opt.tabstop = 4             -- 1 tab = 2 space
vim.opt.smartindent = true      -- smart indent
vim.opt.softtabstop = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv"HOME".."/.local/state/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true -- i like highlight it all, but after search it not turnoff automatially
vim.opt.incsearch = true

vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 12
vim.opt.scroll = 4
vim.opt.signcolumn = "no"
vim.opt.updatetime = 250
vim.opt.colorcolumn = "120"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

