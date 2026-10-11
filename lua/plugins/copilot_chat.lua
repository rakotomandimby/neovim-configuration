local cc_fork="rakotomandimby/CopilotChat.nvim"
local cc_fork_branch="feat/1584-set-reasoning-effort"
local cc_upstream="CopilotC-Nvim/CopilotChat.nvim"
local cc_upstream_branch="main"

return  {
  cc_fork,
  branch = cc_fork_branch,
  dependencies = {
    { "github/copilot.vim" },
    { "rakotomandimby/plenary.nvim", branch = "feat/full-os-getenv" },
  },
  event = "VeryLazy",
  config = require "configs.copilot_chat",
}

