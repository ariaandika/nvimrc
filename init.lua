PLUGIN_SRC = "~/.local/share/nvim/plugins/"
NVIMRC = "~/dev/config/nvim"
vim.opt.rtp:prepend(NVIMRC)
require "basemap"
require "set"
require "util"
require "ariaandika.init"
require "ariaandika.lsp"
require "ariaandika.exp"
