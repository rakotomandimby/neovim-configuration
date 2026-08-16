require("nvchad.configs.lspconfig").defaults()

local lsp_servers = require("configs.lsp_servers")
local servers = lsp_servers.servers

vim.lsp.config("ts_ls", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
  single_file_support = true,
})

vim.lsp.enable(servers)

