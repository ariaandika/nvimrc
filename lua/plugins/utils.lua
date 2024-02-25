-- vim.api.nvim_exec([[
--   autocmd InsertEnter * inoremap { {}<Esc>i
--   autocmd InsertEnter * inoremap ( ()<Esc>i
--   autocmd InsertEnter * inoremap [ []<Esc>i
--   autocmd InsertEnter * inoremap " ""<Esc>i
--   autocmd InsertEnter * inoremap ' ''<Esc>i
--   autocmd InsertEnter * inoremap < <><Esc>i
-- ]], false)


return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require'Comment'.setup({
                toggler = { line = '<C-_>' },
                opleader = { line = '<C-_>' },
            })
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
}
