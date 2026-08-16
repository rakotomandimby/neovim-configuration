local M = {}

M.defaults = {
  blink_duration = 128,
  blink_count = 2,
  highlight_group = "WinBlink",
  debounce_interval = 150,
  colors = {
    bg = "#FFD700",
    fg = "#FFFFFF",
    bold = true,
  },
}

M.options = vim.deepcopy(M.defaults)

function M.setup(user_opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, user_opts or {})
end

return M

