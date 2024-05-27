local set = vim.keymap.set
local desc = function(d) return { desc = d } end
local capabilities = nil
local so = function(id,after)
    vim.opt.rtp:append("~/.local/share/nvim/plugins/" .. id)
    if after then
        vim.opt.rtp:append("~/.local/share/nvim/plugins/" .. id .. "/after")
    end
end


local function on_attach(ev)
    local o = {buffer = ev.bufnr, noremap = true}
    set("n", "gd", vim.lsp.buf.definition, o)
    set("n", "?", vim.lsp.buf.hover, o)
    set("n", "'", vim.lsp.buf.code_action, o)
    set("n", "<F2>", vim.lsp.buf.rename, o)
    set("n", "<leader>h", vim.lsp.buf.signature_help, o)
    set("n", ";", vim.diagnostic.open_float, o)
    set("n", "<leader>gf", vim.lsp.buf.format)

    -- set("n", "<leader>vws", vim.lsp.workspace_symbol, o)
    -- set("n", "<leader>rr", vim.lsp.references, o)
end

local function lua_ls()
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

local function tw_ls()
    require('lspconfig').tailwindcss.setup{
        settings = {
            tailwindCSS = {
                suggestions = false,
                classAttributes = { "class", "cx", "tw", "base" },
            }
        },
        on_attach = function(client)
            on_attach(client)
            -- not work
            client.server_capabilities.completionProvider = false
        end,
        capabilities = capabilities
    }
end

local function lsp_setup()
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
        lua_ls = lua_ls,
        tailwindcss = tw_ls,
    }

    -- Sveltekit
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                    if client.name == "svelte" then
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end
                end,
            })
        end,
    })
end

local function cmp_setup()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    luasnip.config.setup({})

    require("luasnip.loaders.from_vscode").load({paths = "~/dev/config/nvim/snippets"})

    cmp.setup({
        snippet = { expand = function(args)
            luasnip.lsp_expand(args.body)
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

    capabilities = require('cmp_nvim_lsp').default_capabilities()
end

local function extra_setup()
    require("neodev").setup({})

    require("flutter-tools").setup({
        lsp = {
            capabilities = capabilities,
            on_attach = on_attach
        }
    })

    -- local trouble = require("trouble")
    -- trouble.setup({ icons = false })
    -- set("n", "<leader>tt", trouble.toggle, desc("Trouble: toggle"))
    -- set("n", "]d", function() trouble.next({ skip_groups = true, jump = true }) end,     desc("Trouble: next"))
    -- set("n", "[d", function() trouble.previous({ skip_groups = true, jump = true }) end, desc("Trouble: previous"))
end

if os.getenv("LSP") == "0" then
    return
end

so("nvim-lspconfig")
so("mason.nvim")
so("mason-lspconfig.nvim")

so("nvim-cmp")
so("cmp-nvim-lsp",1)
so("cmp-buffer",1)
so("cmp-path",1)
so("cmp-cmdline",1)
so("LuaSnip")
so("cmp_luasnip",1)

so("sqls.nvim",1)

cmp_setup()
lsp_setup()

so("neodev.nvim")
so("flutter-tools.nvim")
-- so("trouble.nvim")

extra_setup()

