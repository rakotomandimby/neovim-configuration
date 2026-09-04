local api_ok, api = pcall(require, "nvim-tree.api")
if not api_ok then
  return nil
end

local D = api.Decorator:extend()

function D:new()
  self.enabled = true
  self.highlight_range = "none"
  self.icon_placement = "after" -- puts it after filename
end

function D:icons(node)
  if node.type ~= "file" then
    return nil
  end

  local count
  local bufnr = vim.fn.bufnr(node.absolute_path)
  if bufnr ~= -1 and vim.api.nvim_buf_is_loaded(bufnr) then
    count = vim.api.nvim_buf_line_count(bufnr)
  else
    local ok, lines = pcall(vim.fn.readfile, node.absolute_path)
    if not ok then
      return nil
    end
    count = #lines
  end

  return { { str = "(" .. tostring(count) .. ")", hl = { "Comment" } } }
end

return D

