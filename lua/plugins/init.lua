return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  -- install nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    branch = "master",
    event = "VeryLazy",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      local lsp_servers = require("configs.lsp_servers")
      return {
        ensure_installed = lsp_servers.servers,
        automatic_installation = true,
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"
      require("luasnip.loaders.from_snipmate").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },
  { "github/copilot.vim", event = "VeryLazy", config = require "configs.copilot" },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = { enabled = true, },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript", "typescript", "tsx",
        "php", "twig", "yaml", "markdown", "markdown_inline",
      },
      auto_install = true,
    },
  },
}
