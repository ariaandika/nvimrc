-- local capabilities = nil

local function on_attach(ev)
    local o = {buffer = ev.bufnr, noremap = true}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
    vim.keymap.set("n", "?", vim.lsp.buf.hover, o)
    vim.keymap.set("n", "'", vim.lsp.buf.code_action, o)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, o)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, o)
    vim.keymap.set("n", ";", vim.diagnostic.open_float, o)
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)

    vim.keymap.set("n", "<leader>vws", vim.lsp.workspace_symbol, o)
    vim.keymap.set("n", "<leader>rr", vim.lsp.references, o)
end

local function lua_ls()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig').lua_ls.setup{
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                completion = { showWord = "Disable" },
                semantic = { variable = false },
                diagnostics = { globals = {'vim'}, },
                workspace = {
                    library = {vim.env.VIMRUNTIME},
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
        root_dir = function()
            return vim.loop.cwd()
        end,
        on_attach = on_attach,
        capabilities = capabilities
    }
end

local function lsp_setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require("mason").setup({})
    -- require('lspconfig').rust_analyzer.setup()
    require("mason-lspconfig").setup({})
    require("mason-lspconfig").setup_handlers {
        function (server_name)
            require("lspconfig")[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities
            }
        end,
        -- ["tsserver"] = function () end
        lua_ls = lua_ls,
    }

end

local function cmp_setup()
    local cmp = require'cmp'

    require("luasnip.loaders.from_vscode").load({paths = "./snippets"})

    cmp.setup({
        snippet = { expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end },
        mapping = cmp.mapping.preset.insert({
            ['<C-up>'] = cmp.mapping.scroll_docs(-4),
            ['<C-down>'] = cmp.mapping.scroll_docs(4),
            ['<C-s>'] = cmp.mapping.complete(),
            ['<Esc>'] = cmp.mapping.abort(),
            ['<S-CR>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        }),
        enabled = function()
            local context = require('cmp.config.context')
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
            end
        end
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {{ name = 'path' }}, {{ name = 'cmdline' }}
        )
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = lsp_setup
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            -- 'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- 'rafamadriz/friendly-snippets',
        },
        config = cmp_setup
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require('fidget').setup()
        end
    },
    {
        "folke/trouble.nvim",
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({ icons = false })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "[d", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end)

            vim.keymap.set("n", "]d", function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end)
        end
    },
    {
        'folke/neodev.nvim',
        -- config = function()
        --     require('neodev').setup()
        -- end
    }
}


-- {
--     'ms-jpq/coq_nvim',
--     dependencies = {
--         'ms-jpq/coq.artifacts' 
--         -- 'ms-jpq/coq.thirdparty', {'branch': '3p'}
--     },
--     config = function()
--         
--         vim.g.coq_settings = {
--             ["auto_start"] = 'shut-up',
--             ["keymap.pre_select"] = true,
--             ["keymap.manual_complete"] = "<c-s>",
--             -- ["keymap.jump_to_mark"] = "<c-h>" , -- default
--             ["display.ghost_text.enabled"] = false,
--             ["display.pum.fast_close"] = false,
--         }
--     end
-- },

