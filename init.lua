PLUGIN_SRC = "~/.local/share/nvim/plugins/"
NVIMRC = "~/dev/config/nvim"

vim.opt.rtp:prepend(NVIMRC)

require("set")
require("basemap")
require("util")
require("ariaandika.telescope")
require("ariaandika.init")
require("ariaandika.lsp")
-- require("ariaandika.exp")
