---@type ChadrcConfig
local M = {}

M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local statusline_modules = require "configs.statusline"

M.ui = {
  tabufline = {
    enabled = false,
  },
  statusline = {
    default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    theme = "vscode",
    modules = {
      file = function()
        return statusline_modules.file(M.stbufnr())
      end,

      lsp = function()
        return statusline_modules.lsp(M.stbufnr())
      end,
    },
  },
}

M.base46 = {
  theme = "flexoki-light",
}

return M

