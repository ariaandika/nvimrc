
---@diagnostic disable-next-line: missing-fields
require 'nvim-treesitter.configs'.setup({
    ensure_installed = { "javascript", "typescript", "lua", "rust" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
    },
})
