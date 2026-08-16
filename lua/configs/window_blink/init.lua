local config = require("configs.window_blink.config")
local animator = require("configs.window_blink.animator")

local M = {}

local function setup_highlight()
  vim.api.nvim_set_hl(0, config.options.highlight_group, config.options.colors)
end

function M.setup(opts)
  config.setup(opts)
  setup_highlight()

  vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "*",
    callback = function()
      vim.defer_fn(animator.blink_window, 10)
    end,
    desc = "Blink window border on focus change",
  })
end

return M

