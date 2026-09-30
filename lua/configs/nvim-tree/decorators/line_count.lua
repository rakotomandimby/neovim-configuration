local api = require("nvim-tree.api")

local LineCountDecorator = api.Decorator:extend()

function LineCountDecorator:new()
  self.enabled = true
  self.highlight_range = "none"
  self.icon_placement = "after" -- puts it after filename
end

local function count_lines(path)
  local bufnr = vim.fn.bufnr(path)
  if bufnr ~= -1 and vim.api.nvim_buf_is_loaded(bufnr) then
    return vim.api.nvim_buf_line_count(bufnr)
  end

  local ok, lines = pcall(vim.fn.readfile, path)
  return ok and #lines or nil
end

function LineCountDecorator:icons(node)
  if node.type ~= "file" then
    return nil
  end

  local count = count_lines(node.absolute_path)
  if not count then
    return nil
  end

  return { { str = "(" .. count .. ")", hl = { "Comment" } } }
end

return LineCountDecorator

