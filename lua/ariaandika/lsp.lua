local set = vim.keymap.set
local so = function(id,after)
  vim.opt.rtp:append(PLUGIN_SRC .. id)
  if after then
    vim.opt.rtp:append(PLUGIN_SRC .. id .. "/after")
  end
end

if os.getenv("LSP") == "0" then
  return
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
end

local function lsp_setup()
  vim.diagnostic.config({
    virtual_text = {
      severity = 'ERROR',
      virt_text_pos = 'eol_right_align',
      source = true,
      prefix = 'Deez:',
    },
  })

  local cap = vim.lsp.protocol.make_client_capabilities()

  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = cap,
  })

  require("typescript-tools").setup{
    on_attach = on_attach,
    capabilities = cap,
  }

  vim.lsp.config.lua_ls = {
    on_attach = on_attach,
    capabilities = cap,
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
  }

  vim.lsp.config.rust_analyzer = {
    on_attach = on_attach,
    capabilities = cap,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          disabled = { "inactive-code" }
        },
        cargo = {
          features = "all",
        },
        check = {
          command = 'clippy',
        },
        -- [source](https://github.com/rust-lang/rust-analyzer/blob/master/crates/ide-completion/src/snippet.rs)
        completion = {
          snippets = {
            custom = {
              pin = {
                postfix = "pin",
                body = "pin!(${receiver})",
                requires = "std::pin::pin",
                description = "Wrap the expression in a `pin!`",
                scope = "expr",
              },
              ready = {
                postfix = "ready",
                body = "ready!(${receiver})",
                requires = "std::task::ready",
                description = "Wrap the expression in a `ready!`",
                scope = "expr",
              },
              ["Poll::Ready"] = {
                postfix = "pollready",
                body = "Ready(${receiver})",
                requires = "std::task::Poll::{self, *}",
                description = "Wrap the expression in a `Poll::Ready`",
                scope = "expr",
              },
              ["ifletErr"] = {
                postfix = "ife",
                body = {
                  "if let Err($0) = ${receiver} {",
                  "    ",
                  "};",
                },
                requires = "std::task::ready",
                description = "Wrap the expression in a `ready!`",
                scope = "expr",
              },
            },
          },
        },
        hover = {
          show = {
            traitAssocItems = 5,
          },
        },
      },
    }
  }

  vim.lsp.config.svelte = {
    on_attach = function(ev)
      on_attach(ev)

  -- Sveltekit
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.d.ts" },
        callback = function(ctx)
          if client ~= nil and client.name == "svelte" then
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end
        end,
      })
    end,
  })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "lua_ls" }
  })

  -- require('lspconfig').gleam.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities
  -- })
end

local function cmp_setup()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  luasnip.config.setup({})

  require("luasnip.loaders.from_vscode").load({paths = NVIMRC .. "/snippets"})

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
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
      -- else
      -- local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      -- if buftype == "prompt" then
      --   return false
      -- end
        return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
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

-- local function extra_setup()
--   require("flutter-tools").setup({
--     lsp = {
--       capabilities = cap,
--       on_attach = on_attach
--     }
--   })
-- end

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
so('typescript-tools.nvim')

cmp_setup()
lsp_setup()

so("neodev.nvim")
so("flutter-tools.nvim")

-- extra_setup()

