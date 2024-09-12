local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer' -- Buffer completions
    use 'hrsh7th/cmp-path' -- Path completions


    use 'morhetz/gruvbox'
    use 'folke/tokyonight.nvim'
    use 'projekt0n/github-nvim-theme'
    use 'joshdick/onedark.vim'

    use 'neovim/nvim-lspconfig'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.cmd [[colorscheme github_dark]]

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

lspconfig.gopls.setup({
    on_attach = on_attach,
    settings = {
        gopls = {
      -- Enables auto-fix for missing imports
        gofumpt = true,   -- Uses gofumpt for formatting
        analyses = {
            unusedparams = true,  -- Checks for unused parameters
        },
        staticcheck = true, -- Enable additional static analysis checks
        completeUnimported = true, -- Auto-complete unimported packages
        usePlaceholders = true, -- Add placeholders for function arguments
        },
    },
})

lspconfig.pyright.setup{}
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For  users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})
