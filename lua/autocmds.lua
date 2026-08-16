require "nvchad.autocmds"

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(args)
    local lsp_keymaps = require "configs.lsp_keymaps"
    lsp_keymaps.apply(args.buf)
  end,
})

-- Custom autocommands for EJS files
local ejs_group = vim.api.nvim_create_augroup("EjsFileTypeOpts", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ejs_group,
  pattern = "*.ejs",
  callback = function(args)
    pcall(vim.cmd, "silent! LspStart html")
    pcall(vim.cmd, "silent! Copilot enable")
  end,
  desc = "Start HTML LSP and enable Copilot for EJS files",
})

