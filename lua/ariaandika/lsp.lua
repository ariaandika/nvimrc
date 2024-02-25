local set = vim.keymap.set
local desc = function(d) return { desc = d } end
local capabilities = nil


local function on_attach(ev)
    local o = {buffer = ev.bufnr, noremap = true}
    set("n", "gd", vim.lsp.buf.definition, o)
    set("n", "?", vim.lsp.buf.hover, o)
    set("n", "'", vim.lsp.buf.code_action, o)
    set("n", "<F2>", vim.lsp.buf.rename, o)
    set("n", "<leader>h", vim.lsp.buf.signature_help, o)
    set("n", ";", vim.diagnostic.open_float, o)
    set("n", "<leader>gf", vim.lsp.buf.format)

    set("n", "<leader>vws", vim.lsp.workspace_symbol, o)
    set("n", "<leader>rr", vim.lsp.references, o)
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
        -- ["tsserver"] = function () end
        lua_ls = lua_ls,
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

    require("cmp_nvim_lsp").setup()
    cmp.register_source('buffer', require('cmp_buffer'))
    cmp.register_source('path', require('cmp_path').new())
    cmp.register_source('cmdline', require('cmp_cmdline').new())

    --#region
    cmp.register_source("luasnip", require("cmp_luasnip").new())

    local cmp_luasnip = vim.api.nvim_create_augroup("cmp_luasnip", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "LuasnipCleanup",
      callback = function ()
        require("cmp_luasnip").clear_cache()
      end,
      group = cmp_luasnip
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LuasnipSnippetsAdded",
      callback = function ()
        require("cmp_luasnip").refresh()
      end,
      group = cmp_luasnip
    })
    --#endregion

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

    capabilities = require('cmp_nvim_lsp').default_capabilities()
end

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/nvim-lspconfig")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/mason.nvim")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/mason-lspconfig.nvim")

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/nvim-cmp")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/cmp-nvim-lsp")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/cmp-buffer")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/cmp-path")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/cmp-cmdline")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/LuaSnip")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/cmp_luasnip")

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/fidget.nvim")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/trouble.nvim")
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/neodev.nvim")

lsp_setup()
cmp_setup()

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/flutter-tools.nvim")

require("flutter-tools").setup({
    lsp = {
        capabilities = capabilities,
        on_attach = on_attach
    }
})

local trouble = require("trouble")
trouble.setup({ icons = false })
set("n", "<leader>tt", trouble.toggle, desc("Trouble: toggle"))
set("n", "]d", function() trouble.next({ skip_groups = true, jump = true }) end,     desc("Trouble: next"))
set("n", "[d", function() trouble.previous({ skip_groups = true, jump = true }) end, desc("Trouble: previous"))

