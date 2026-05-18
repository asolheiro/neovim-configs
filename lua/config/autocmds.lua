local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

-- ─── Language-specific indentation ────────────────────────────────────────────
au("FileType", {
  group = ag("indent_go", { clear = true }),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

au("FileType", {
  group = ag("indent_web", { clear = true }),
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact",
              "json", "jsonc", "html", "css", "scss", "yaml", "dart" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- ─── Close misc filetypes with 'q' ────────────────────────────────────────────
au("FileType", {
  group = ag("close_with_q", { clear = true }),
  pattern = { "help", "man", "qf", "lspinfo", "mason", "lazy", "checkhealth", "startuptime" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
  end,
})

-- ─── Disable comment continuation ─────────────────────────────────────────────
au("FileType", {
  group = ag("no_comment_newline", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ─── Dockerfile filetype detection ────────────────────────────────────────────
au({ "BufNewFile", "BufRead" }, {
  group = ag("dockerfile_ft", { clear = true }),
  pattern = { "Dockerfile*", "*.dockerfile", "*.Dockerfile" },
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

-- ─── Helm template detection ──────────────────────────────────────────────────
au({ "BufNewFile", "BufRead" }, {
  group = ag("helm_ft", { clear = true }),
  pattern = { "*/templates/*.yaml", "*/templates/*.yml", "*/chart/*.yaml" },
  callback = function()
    vim.bo.filetype = "helm"
  end,
})

-- ─── Return to last edited position ──────────────────────────────────────────
au("BufReadPost", {
  group = ag("last_position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
