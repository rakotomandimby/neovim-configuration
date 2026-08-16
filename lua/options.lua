require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both"
o.cursorline = true
o.cursorcolumn = true

o.number = true
o.relativenumber = true

vim.filetype.add {
  extension = {
    snippets = "snippets",
    ejs = "html",
  },
}

local k = vim.keymap
-- Disable macro recording by remapping "q" to do nothing
k.set("n", "q", "<Nop>", { noremap = true, silent = true, desc = "Disable macro recording" })

