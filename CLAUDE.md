# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/). The repo is meant to be cloned to `~/.config/nvim`. Supports Go, Rust, Python, TypeScript/Next.js, Flutter/Dart, Kubernetes/Helm, and Terraform.

## Applying and Testing Changes

This repo has no build step and **is** the live config (`~/.config/nvim`) — changes take effect the next time Neovim loads the files.

```bash
# Test inside Neovim after changes
nvim +checkhealth          # verify environment
nvim +"Lazy sync"          # sync plugins (add/remove)
nvim +"Lazy update"        # update all plugins to latest

# Reload config without restarting (from inside nvim)
:source $MYVIMRC
```

Mason (LSP/DAP/formatter installer) runs automatically on first open. After adding a tool to `mason.opts.ensure_installed` in `infra.lua`, open nvim and run `:MasonInstall <tool>` or restart for auto-install. Many Mason packages are built with `go install` or `npm`: if `go`/`node` are not on the `PATH` of the nvim process, installs fail (`:MasonLog`, `~/.local/state/nvim/mason.log`).

### Headless verification

Startup errors can be captured without a UI. Two gotchas: `User VeryLazy` never fires headless (LazyVim creates most keymaps there — trigger it by hand before inspecting maps), and `:MasonInstall` + `+qa` quits before the install finishes (wait on `pkg:is_installing()`).

```bash
# output goes to a file: print() is invisible headless, and the handle must be closed or it stays empty
# messages shown at startup for a given filetype (wait for lazy-loaded LSP/linters)
nvim --headless file.md "+lua vim.defer_fn(function() local f=io.open('/tmp/m.txt','w') f:write(vim.api.nvim_exec2('messages',{output=true}).output) f:close() vim.cmd('qa!') end, 10000)"

# effective mapping for a key
nvim --headless "+lua vim.api.nvim_exec_autocmds('User',{pattern='VeryLazy'})" "+lua vim.defer_fn(function() local f=io.open('/tmp/m.txt','w') f:write(vim.inspect(vim.fn.maparg(' cf','n',false,true).desc)) f:close() vim.cmd('qa!') end, 5000)"
```

## Architecture

### Entry Point

`init.lua` → `lua/config/lazy.lua` (bootstrap + full plugin spec)

`lazy.lua` is the central spec file: it imports LazyVim core, all LazyVim language/editor extras, and then `{ import = "plugins" }` which loads every file under `lua/plugins/`.

**Import order matters.** Specs merge in import order and later plain-table `opts` override earlier ones. `dap.core` must stay **before** the language extras: it sets `mason-nvim-dap` `automatic_installation = true`, which would otherwise wipe the typescript extra's `{ exclude = { "chrome" } }` and trigger `Cannot find package "chrome-debug-adapter"`. Both the `editor.fzf` and `editor.telescope` extras are imported; fzf-lua comes last and is the active picker.

### Config Layer (`lua/config/`)

| File | Purpose |
|---|---|
| `lazy.lua` | lazy.nvim bootstrap; declares all LazyVim extras and plugin imports |
| `options.lua` | `vim.opt` overrides (relative numbers, colorcolumn=100, scrolloff=8, tabs=4) |
| `keymaps.lua` | Custom keymaps not handled by which-key/LazyVim |
| `autocmds.lua` | FileType indentation rules, filetype detection (Dockerfile, Helm), misc autocmds |

### Plugin Layer (`lua/plugins/`)

Each file returns a list of lazy.nvim plugin specs. Adding a new file here is automatically picked up — no registration needed.

| File | Responsibility |
|---|---|
| `editor.lua` | which-key group labels, neo-tree, git-blame, diffview, tmux navigator |
| `lang.lua` | Language-specific plugins: go.nvim, rustaceanvim, flutter-tools, venv-selector, ts-error-translator, render-markdown, markdown-preview; markdownlint wiring (nvim-lint/conform `--config`, `<leader>mf`, `<leader>md`) |
| `infra.lua` | Infra stack: vim-helm, helm-ls, vim-terraform, k8s.nvim, YAML schemas, conform.nvim formatters, Mason ensure_installed (deduplicated) |
| `terminal.lua` | toggleterm (float/horizontal/vertical), lazygit terminal, Python REPL |
| `ui.lua` | tokyonight, lualine (LSP name display), bufferline, indent-blankline, neoscroll, dashboard, nvim-notify, nvim-colorizer |

### Key Conventions

- **LSP management**: LazyVim extras handle LSP setup; `lang.lua` plugins set `lsp_cfg = false` / `lsp_on_attach = false` to avoid conflicts with LazyVim's lspconfig.
- **Formatting**: All formatters declared in `infra.lua` via `conform.nvim`. Format-on-save is LazyVim's own (`vim.g.autoformat`, toggled with `<leader>uf`) — **don't set `opts.format_on_save`** in conform: LazyVim ignores it and warns at startup.
- **Mason `ensure_installed`**: `infra.lua` uses an `opts` function that appends its tools and then deduplicates the final list. LazyVim installs each entry without dedup, and the extras already add several tools (goimports, gofumpt, delve, stylua, shfmt, codelldb); a repeated not-yet-installed package breaks mason's config with `Package is already installing`.
- **Markdown lint**: base rules in `markdownlint/.markdownlint.yaml` (MD013 and MD060 off), passed with `--config` via `prepend_args` to both nvim-lint and conform; a project's own `.markdownlint*` still layers on top. nvim-lint lints via stdin, so project config is found relative to nvim's cwd.
- **Indentation**: Go uses tabs/4; web stack (TS, JS, JSON, YAML, Dart) uses spaces/2; everything else spaces/4. Set in `autocmds.lua`.
- **Keymaps**: Language-specific keymaps (Go, Rust, Flutter) are declared inline in the plugin's `keys = {}` table inside `lang.lua`. Global custom keymaps go in `keymaps.lua`.
- **Leader**: `<Space>` (LazyVim default). Group labels registered in `editor.lua` via which-key spec.

### Adding a New Language

1. Add the LazyVim extra (if available) in `lazy.lua`: `{ import = "lazyvim.plugins.extras.lang.<name>" }`
2. Add any extra plugin to `lang.lua` with `ft = "<filetype>"` to keep it lazy-loaded
3. Add formatters to `conform.opts.formatters_by_ft` in `infra.lua`
4. Add LSP/formatter/DAP names to the list in the `mason.nvim` `opts` function in `infra.lua` (duplicates are fine, the function dedups)
5. Document new keymaps in `SHORTCUTS.md`, the language row in `README.md`, and run `scripts/gerar-cheatsheet.sh`

### Cheatsheet

`CHEATSHEET.md` is **generated** — never edit it by hand. `scripts/gerar-cheatsheet.sh` runs nvim headless with `scripts/cheatsheet.lua`, which fires `User VeryLazy`, opens `lua/config/keymaps.lua` and waits for lua_ls + gitsigns to attach (buffer-local LSP/hunk maps), adds `keys` with `ft` from the lazy specs and rustaceanvim's `on_attach` maps, and groups sections by which-key group names (`require("which-key.config").mappings`, name in `desc`). Only maps with a `desc` are listed, so always give new keymaps a `desc`. Regenerate after changing keymaps; `scripts/cheatsheet-pdf.sh [--gerar]` exports `CHEATSHEET.pdf` (gitignored) with marked (npm) + headless Chrome. `SHORTCUTS.md` stays the hand-written, commented reference.

### lock file

`lazy-lock.json` pins exact plugin versions. Commit it to reproduce the exact setup. Run `:Lazy update` + commit the updated lockfile when upgrading plugins.
