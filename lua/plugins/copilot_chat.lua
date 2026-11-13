return  {
  "code-ai-nvim/copilot-chat.nvim",
  branch = main,
  dependencies = {
    { "github/copilot.vim" },
    { "rakotomandimby/plenary.nvim", branch = "feat/full-os-getenv" },
  },
  event = "VeryLazy",
  config = require "configs.copilot_chat",
}

