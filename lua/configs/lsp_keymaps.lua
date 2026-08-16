local M = {}

local function supports_method(method, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

local function with_telescope(picker, fallback, method, bufnr)
  if method and not supports_method(method, bufnr) then
    fallback()
    return
  end

  local ok, tb = pcall(require, "telescope.builtin")
  if ok and type(tb[picker]) == "function" then
    tb[picker]()
  else
    fallback()
  end
end

function M.goto_definition(bufnr)
  local fallback = function()
    vim.lsp.buf.definition()
  end
  with_telescope("lsp_definitions", fallback, "textDocument/definition", bufnr)
end

function M.list_references(bufnr)
  local fallback = function()
    vim.lsp.buf.references()
  end
  with_telescope("lsp_references", fallback, "textDocument/references", bufnr)
end

local function map(lhs, rhs, desc, bufnr)
  local opts = { noremap = true, silent = true, desc = desc }
  if bufnr then
    opts.buffer = bufnr
  end
  vim.keymap.set("n", lhs, rhs, opts)
end

function M.apply(bufnr)
  map("gd", function()
    M.goto_definition(bufnr)
  end, "LSP: Go to definition", bufnr)

  map("gr", function()
    M.list_references(bufnr)
  end, "LSP: References", bufnr)

  map("K", vim.lsp.buf.hover, "LSP: Hover documentation", bufnr)
  map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action", bufnr)
  map("<leader>lr", vim.lsp.buf.rename, "LSP: Rename", bufnr)
  map("<leader>D", vim.lsp.buf.type_definition, "LSP: Type definition", bufnr)
end

return M
