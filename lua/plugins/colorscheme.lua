return {
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local c = require("onedark.palette")
            require('onedark').setup {
                style = 'dark',
                transparent = true,
                highlights = {
                    ["@parameter"] = {fmt = 'italic,bold'},
                    ["@parameter.reference"] = {fg = c.dark.red},
                },
                code_style = {
                    comments = 'bold',
                    -- keywords = 'none',
                    -- functions = 'none',
                    -- strings = 'none',
                    -- variables = 'none'
                },
            }
            require('onedark').load()
        end
    },
    'folke/tokyonight.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'nvim-treesitter.configs'.setup({
                -- IT REINSTALL EVERY NVIM OPEN
                -- ensure_installed = { "javascript", "typescript", "lua", "rust" },
                -- auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                -- indent = {
                --     enable = false,
                -- },
            })
        end
    }
}
