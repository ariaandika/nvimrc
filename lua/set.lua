local g = vim.g
local opt = vim.opt

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

opt.guicursor = ""
opt.nu = true
opt.relativenumber = true
opt.timeout = false

opt.shiftwidth = 4          -- when use "<" or ">"
opt.expandtab = true        -- use spaces by default
opt.tabstop = 4             -- 1 tab = 2 space
opt.smartindent = true      -- smart indent
opt.softtabstop = 4

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv"HOME".."/.local/state/nvim/undodir"
opt.undofile = true

opt.hlsearch = false -- i like highlight it all, but after search it not turnoff automatially
opt.incsearch = true

opt.wrap = false
opt.termguicolors = true
opt.scrolloff = 12
opt.scroll = 4
opt.signcolumn = "no"
opt.updatetime = 50
opt.colorcolumn = "120"
opt.ignorecase = true
opt.smartcase = true


