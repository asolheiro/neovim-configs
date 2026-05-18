-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "Warn" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim core + its defaults
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "tokyonight-night" } },

    -- ── Language Extras ─────────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.dart" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.toml" },

    -- ── Editor Extras ────────────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.editor.telescope" },
    { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- ── UI Extras ────────────────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },

    -- ── DAP (Debugger) ───────────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.dap.core" },

    -- ── Your custom plugins ──────────────────────────────────────────────────
    { import = "plugins" },
  },

  defaults = { lazy = false, version = false },

  install = { colorscheme = { "tokyonight", "habamax" } },

  checker = { enabled = true, notify = false },

  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
