PLUGIN_SRC = "~/.local/share/nvim/plugins/"
NVIMRC = "~/dev/config/nvim"

vim.opt.rtp:prepend(NVIMRC)

require("set")
require("basemap")
require("rust")
require("ariaandika.telescope")
require("ariaandika.plugins")
require("ariaandika.lsp")
-- require("ariaandika.exp")
