local M = {}

local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

local client_name_map = {
  ["GitHub Copilot"] = "github_copilot",
  ["copilot"] = "github_copilot",
}

local lsp_cache = {}

local function compute_lsp(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if not clients or #clients == 0 then
    return ""
  end

  local client_names = {}
  for _, client in ipairs(clients) do
    if client.name then
      local formatted_name = client_name_map[client.name] or client.name
      table.insert(client_names, formatted_name)
    end
  end

  if #client_names == 0 then
    return ""
  end

  table.sort(client_names)

  local lsp_str = table.concat(client_names, ", ")
  return "  󰄭 " .. lsp_str .. "  "
end

function M.update_lsp_cache(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  lsp_cache[bufnr] = compute_lsp(bufnr)
end

function M.file(stbufnr)
  local icon = "󰈚"
  local path = vim.api.nvim_buf_get_name(stbufnr)
  local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"
  name = vim.fn.fnamemodify(path, ":.")

  if name ~= "Empty" and devicons_ok then
    local ft_icon = devicons.get_icon(name)
    icon = (ft_icon ~= nil and ft_icon) or icon
  end
  return "    " .. icon .. " " .. name .. "    "
end

function M.lsp(stbufnr)
  if lsp_cache[stbufnr] == nil then
    M.update_lsp_cache(stbufnr)
  end
  return lsp_cache[stbufnr]
end

local group = vim.api.nvim_create_augroup("StatuslineLspCache", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
  group = group,
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        M.update_lsp_cache(args.buf)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = group,
  callback = function(args)
    lsp_cache[args.buf] = nil
  end,
})

return M

