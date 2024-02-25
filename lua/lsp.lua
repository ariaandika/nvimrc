local lsp = require "lspconfig"
local cmp = require "cmp"

-- LuaSnip, snippet
-- require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/deuzo/.config/Code/User/snippets/javascript.json" } })


-- Neodev, nvim setting tools
require("neodev").setup({ })

-- Language server installer
local default_capabilities = require'cmp_nvim_lsp'.default_capabilities()
local lua_ls = function()
    lsp.lua_ls.setup{
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
        root_dir = function(_)
            return vim.loop.cwd()
        end,
        capabilities = default_capabilities
    }
end

require("mason").setup()

require('mason-lspconfig').setup({
    handlers = {
        function(server)
            lsp[server].setup({ capabilities = default_capabilities, })
        end,
        -- language specific settings
        lua_ls = lua_ls,

        -- ["rust_analyzer"] = function() end
        ["intelephense"] = function()
            lsp.intelephense.setup{
                cmd = { 'intelephense', '--stdio' };
                filetypes = { 'php' };
                root_dir = function(fname)
                    return vim.loop.cwd()
                end;
                settings = {
                    intelephense = {
                        files = {
                            maxSize = 5000000;
                        };
                    }
                },
                capabilities = default_capabilities
            }
        end
    }
})

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

-- Completion
cmp.setup{
  snippet = {expand = function(args) require'luasnip'.lsp_expand(args.body) end},
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
  }),
  enabled = function()
    -- disable completion in prompt / telescope
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    if buftype == "prompt" then return false end

    -- disable completion in comments
    local context = require 'cmp.config.context'

    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end,

  formatting = {
    format = function(entry, vim_item)
      -- This concatonates the icons with the name of the item kind
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
      })[entry.source.name]
      return vim_item
    end
  },
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{ name = 'path' }}, { { name = 'cmdline' } })
})


-- Sveltekit
local function on_attach(_on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      _on_attach(client, buffer)
    end,
  })
end

on_attach(function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.js", "*.ts" },
    callback = function(ctx)
      if client.name == "svelte" then
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end
    end,
  })
end)

-- Lsp Keybinding
vim.api.nvim_create_autocmd('LspAttach',{
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local o = {buffer = ev.bufnr, noremap = true}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
    vim.keymap.set("n", "?", vim.lsp.buf.hover, o)
    vim.keymap.set("n", "'", vim.lsp.buf.code_action, o)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, o)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, o)
    vim.keymap.set("n", ";", vim.diagnostic.open_float, o)
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
  end
})

