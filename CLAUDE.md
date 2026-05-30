# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/). The repo is meant to be cloned to `~/.config/nvim`. Supports Go, Rust, Python, TypeScript/Next.js, Flutter/Dart, Kubernetes/Helm, and Terraform.

## Applying and Testing Changes

This repo has no build step — changes take effect when Neovim loads the files.

```bash
# Deploy to active config location
cp -r . ~/.config/nvim/

# Test inside Neovim after changes
nvim +checkhealth          # verify environment
nvim +"Lazy sync"          # sync plugins (add/remove)
nvim +"Lazy update"        # update all plugins to latest

# Reload config without restarting (from inside nvim)
:source $MYVIMRC
```

Mason (LSP/DAP/formatter installer) runs automatically on first open. After adding a tool to `mason.opts.ensure_installed` in `infra.lua`, open nvim and run `:MasonInstall <tool>` or restart for auto-install.

## Architecture

### Entry Point

`init.lua` → `lua/config/lazy.lua` (bootstrap + full plugin spec)

`lazy.lua` is the central spec file: it imports LazyVim core, all LazyVim language/editor extras, and then `{ import = "plugins" }` which loads every file under `lua/plugins/`.

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
| `lang.lua` | Language-specific plugins: go.nvim, rustaceanvim, flutter-tools, venv-selector, ts-error-translator, render-markdown |
| `infra.lua` | Infra stack: vim-helm, helm-ls, vim-terraform, k8s.nvim, YAML schemas, conform.nvim formatters, Mason ensure_installed |
| `terminal.lua` | toggleterm (float/horizontal/vertical), lazygit terminal, Python REPL |
| `ui.lua` | tokyonight, lualine (LSP name display), bufferline, indent-blankline, neoscroll, dashboard, nvim-notify, nvim-colorizer |

### Key Conventions

- **LSP management**: LazyVim extras handle LSP setup; `lang.lua` plugins set `lsp_cfg = false` / `lsp_on_attach = false` to avoid conflicts with LazyVim's lspconfig.
- **Formatting**: All formatters declared in `infra.lua` via `conform.nvim`; format-on-save is enabled globally (2s timeout, LSP fallback).
- **Indentation**: Go uses tabs/4; web stack (TS, JS, JSON, YAML, Dart) uses spaces/2; everything else spaces/4. Set in `autocmds.lua`.
- **Keymaps**: Language-specific keymaps (Go, Rust, Flutter) are declared inline in the plugin's `keys = {}` table inside `lang.lua`. Global custom keymaps go in `keymaps.lua`.
- **Leader**: `<Space>` (LazyVim default). Group labels registered in `editor.lua` via which-key spec.

### Adding a New Language

1. Add the LazyVim extra (if available) in `lazy.lua`: `{ import = "lazyvim.plugins.extras.lang.<name>" }`
2. Add any extra plugin to `lang.lua` with `ft = "<filetype>"` to keep it lazy-loaded
3. Add formatters to `conform.opts.formatters_by_ft` in `infra.lua`
4. Add LSP/formatter/DAP names to `mason.opts.ensure_installed` in `infra.lua`

### lock file

`lazy-lock.json` pins exact plugin versions. Commit it to reproduce the exact setup. Run `:Lazy update` + commit the updated lockfile when upgrading plugins.
