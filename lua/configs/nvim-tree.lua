local M = {}

local LineCountDecorator = require("utils.line_count_decorator")

M.opts = {
  filters = { dotfiles = false, },
  disable_netrw = true,
  hijack_netrw = true,
  git = { enable = true, },
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
    decorators = {
      "Git",
      "Open",
      "Hidden",
      "Modified",
      "Bookmark",
      "Diagnostics",
      "Copied",
      LineCountDecorator,
      "Cut",
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
}

function M.setup()
  require("nvim-tree").setup(M.opts)
end

return M

