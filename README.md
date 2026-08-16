# Neovim configuration

This repository is a personal [Neovim](https://neovim.io/) configuration built on top of [NvChad](https://github.com/NvChad/NvChad).
It keeps NvChad as the base distribution and layers custom Lua modules, plugin specifications, editor behavior, AI helpers, snippets, and UI tweaks on top of it.

## What this repository is

- A custom Neovim 0.11+ setup
- An NvChad-based configuration loaded through `lazy.nvim`
- A Lua-first configuration that uses modern Neovim APIs such as `vim.lsp.config()` and `vim.lsp.enable()`
- A focused editing environment for Lua, web development, shell, YAML, PHP, and Markdown work

## How it is organized

### Entry point

- `init.lua`
  - Bootstraps `lazy.nvim`
  - Loads `NvChad/NvChad` as the base plugin layer
  - Imports local plugin specs from `lua/plugins`
  - Loads local options, autocommands, mappings, and the window blink module

### Core local modules

- `lua/options.lua`
  - Extends NvChad defaults
  - Enables cursorline, cursorcolumn, absolute and relative line numbers
  - Adds filetype detection for `.snippets` and `.ejs`

- `lua/autocmds.lua`
  - Extends NvChad autocommands
  - Applies LSP keymaps on `LspAttach`
  - Starts the HTML language server and enables Copilot automatically for EJS buffers

- `lua/mappings.lua`
  - Keeps NvChad mappings and adjusts them
  - Adds window resizing shortcuts
  - Adds file path yanking helpers
  - Adds buffer closing and file deletion helpers
  - Adds Copilot Chat commands and a NvimTree toggle

- `lua/utils/actions.lua`
  - Implements custom editor actions used by mappings
  - Handles safe buffer replacement on close
  - Supports copying absolute paths, relative paths, filenames, and basenames
  - Supports deleting the current file from inside Neovim

### UI customization

- `lua/chadrc.lua`
  - Disables the tab buffer line
  - Uses the `vscode` statusline theme
  - Selects the `flexoki-light` Base46 theme
  - Wires custom statusline modules

- `lua/configs/statusline.lua`
  - Shows file path information
  - Caches attached LSP client names
  - Normalizes Copilot naming in the statusline

- `lua/configs/window_blink/*`
  - Implements a custom blinking border effect when entering a window
  - Uses floating windows and highlight groups to draw the effect

### LSP and formatting

- `lua/configs/lspconfig.lua`
  - Starts from NvChad LSP defaults
  - Configures `ts_ls` with Neovim 0.11+ style `vim.lsp.config()`
  - Enables all configured language servers with `vim.lsp.enable()`

- `lua/configs/lsp_servers.lua`
  - Declares the managed language servers:
    - `html`
    - `cssls`
    - `ts_ls`
    - `lua_ls`
    - `bashls`
    - `yamlls`
    - `intelephense`
    - `eslint`

- `lua/configs/lsp_keymaps.lua`
  - Provides buffer-local LSP mappings
  - Uses Telescope pickers when available for definitions and references

- `lua/configs/conform.lua`
  - Configures formatting through `conform.nvim`
  - Currently enables `stylua` for Lua

### Plugins and integrations

Plugin specifications live in `lua/plugins`.
This configuration adds or customizes:

- `NvChad/NvChad` as the base distribution
- `folke/lazy.nvim` for plugin management
- `stevearc/conform.nvim` for formatting
- `nvim-tree/nvim-tree.lua` for file browsing
- `neovim/nvim-lspconfig` and `williamboman/mason-lspconfig.nvim` for LSP support
- `L3MON4D3/LuaSnip` for snippets
- `nvim-treesitter/nvim-treesitter` for syntax parsing
- `github/copilot.vim` for inline AI completion
- `CopilotC-Nvim/CopilotChat.nvim` for chat-based AI workflows
- `f-person/git-blame.nvim` for inline Git blame information
- `code-ai-nvim/code-ai.nvim` for additional AI prompt workflows

### Snippets and AI prompt helpers

- `snippets/html.snippets`
  - HTML snippets for common tags

- `snippets/markdown.snippets`
  - Reusable prompt snippets for AI-assisted work

- `.ai-system-instructions.md`
  - A custom system prompt file consumed by Copilot Chat when present

## Behavior highlights

This setup is centered around a few clear ideas:

- keep NvChad as the stable base instead of rebuilding everything from scratch
- use Neovim 0.11+ native LSP configuration patterns
- keep common actions close at hand through custom mappings
- improve navigation and feedback with a custom statusline and window-focus blink
- integrate AI tools directly into the editing workflow
- keep local snippets and prompt helpers in the repository

## Who this configuration suits

This repository is especially suitable for someone who wants:

- NvChad as a maintained base
- personal but lightweight customization
- modern Neovim LSP configuration
- built-in Copilot and Copilot Chat workflows
- support for web, Lua, shell, YAML, PHP, and Markdown editing

## Acknowledgements

This configuration is only possible because of the work of others.

- [Neovim](https://neovim.io/) for the editor and Lua API foundation
- [NvChad](https://github.com/NvChad/NvChad) for the base distribution, UI conventions, and defaults
- [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim), and the language-server authors for LSP support
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for parsing and syntax support
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snippet support
- [conform.nvim](https://github.com/stevearc/conform.nvim) for formatting
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for file-tree navigation
- [copilot.vim](https://github.com/github/copilot.vim) and [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) for AI assistance
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim) for inline Git context
- [LazyVim starter](https://github.com/LazyVim/starter), which also helped inspire the broader starter experience around NvChad
- all plugin authors, maintainers, and contributors whose work this configuration builds upon
