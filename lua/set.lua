local g = vim.g

g.shiftwidth = 4

vim.cmd[[command W write]]
vim.cmd[[command Wa wall]]
vim.cmd[[command WA wall]]
vim.cmd[[command Wq wq]]
vim.cmd[[command Q q]]

-- overwrite TreeSitter :EditQuery, it keeps biting me
vim.cmd[[command E noh]]

vim.api.nvim_exec2([[
  autocmd InsertEnter * inoremap { {}<Left>
  autocmd InsertEnter * inoremap ( ()<Left>
  autocmd InsertEnter * inoremap [ []<Left>
  autocmd InsertEnter * inoremap " ""<Left>
  " autocmd InsertEnter * inoremap ' ''<Left>
  autocmd InsertEnter * inoremap < <><Left>
]],{})

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.timeout = false

vim.opt.shiftwidth = 2          -- when use "<" or ">"
vim.opt.expandtab = true        -- use spaces by default
vim.opt.tabstop = 2             -- 1 tab = 2 space
vim.opt.smartindent = true      -- smart indent
vim.opt.softtabstop = 2

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

local indent4 = { "rust", "c", "cpp", "zig" }

for i = 1, #indent4, 1 do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = indent4[i],
    callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
    end
  })
end
