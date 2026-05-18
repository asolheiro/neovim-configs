-- Overrides on top of LazyVim defaults
local opt = vim.opt

opt.relativenumber = true
opt.colorcolumn = "100"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.timeoutlen = 300
opt.wrap = false

-- Folding via treesitter (LazyVim sets ufo, keep consistent)
opt.foldlevel = 99

-- Language-specific tab widths are handled in autocmds.lua
-- Go uses tabs (4); web stack uses 2-space; everything else 4-space
opt.tabstop = 4
opt.shiftwidth = 4

-- Cross-platform clipboard
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "wsl",
    copy  = { ["+"] = "clip.exe",    ["*"] = "clip.exe" },
    paste = { ["+"] = { "powershell.exe", "-c", "[Console]::Out.Write($(Get-Clipboard -Raw))" },
              ["*"] = { "powershell.exe", "-c", "[Console]::Out.Write($(Get-Clipboard -Raw))" } },
    cache_enabled = false,
  }
end
