require "nvchad.mappings"
pcall(vim.keymap.del, "n", "<TAB>")
pcall(vim.keymap.del, "n", "<leader>x")

local actions = require "utils.actions"
local map = vim.keymap.set

map("n", "<C-Right>", "<C-w>10>", { desc = "Increase window size by 10" })
map("n", "<C-Left>", "<C-w>10<", { desc = "Decrease window size by 10" })

local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify("which-key not found!", vim.log.levels.ERROR)
  return
end

wk.add({
  { "<leader>x", actions.close_buffer, desc = "Close buffer" },
  { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
  { "<leader>v", "<cmd>vsplit<CR>", desc = "Vertical split" },

  { "<leader>l", group = "Lazy" },
  { "<leader>lu", "<cmd>Lazy update<CR>", desc = "Lazy Update" },

  { "<leader>y", group = "Yank Paths" },
  { "<leader>ya", function() actions.yank_file_info("%:p", "absolute path", "file path", "File Path") end, desc = "Yank absolute file path" },
  { "<leader>yr", function() actions.yank_file_info("%:.", "relative path", "file path", "File Path") end, desc = "Yank relative file path" },
  { "<leader>yf", function() actions.yank_file_info("%:t", "filename", "filename", "File Name") end, desc = "Yank filename" },
  { "<leader>yb", function() actions.yank_file_info("%:t:r", "basename", "basename", "File Basename") end, desc = "Yank basename" },

  { "<leader>c", group = "Copilot" },
  { "<leader>cc", group = "CopilotChat" },
  { "<leader>cco", "<cmd>CopilotChatOpen<CR>", desc = "Open Copilot Chat" },
  { "<leader>ccc", "<cmd>CopilotChatClose<CR>", desc = "Close Copilot Chat" },
  { "<leader>cct", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
  { "<leader>ccs", "<cmd>CopilotChatStop<CR>", desc = "Stop Copilot Chat" },
  { "<leader>ccr", "<cmd>CopilotChatReset<CR>", desc = "Reset Copilot Chat" },
  { "<leader>ccp", "<cmd>CopilotChatPrompts<CR>", desc = "Show Prompts" },
  { "<leader>ccm", "<cmd>CopilotChatModels<CR>", desc = "Show Models" },

  { "<leader>d", group = "Delete" },
  { "<leader>dcf", actions.delete_current_file, desc = "Delete current file" },
}, { mode = "n" })

