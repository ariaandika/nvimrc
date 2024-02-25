vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    use 'theprimeagen/harpoon'
    use 'tpope/vim-fugitive'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope.nvim'

    use 'folke/neodev.nvim'
    use 'mbbill/undotree'
    -- use 'LunarWatcher/auto-pairs'

    -- mason
    use {
        "williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
    }

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            "rafamadriz/friendly-snippets"
        }
    }

    -- COC
    -- no documentation for configuration
    -- use { 'neoclide/coc.nvim', branch = "release" }

    -- Copilot
    use {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
    }

    -- colors
    use 'navarasu/onedark.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use 'numToStr/Comment.nvim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }


    -- Problem with remapped <CR>
    -- use 'jiangmiao/auto-pairs'

end)
--
