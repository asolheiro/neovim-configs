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

-- ─── Markdown heading navigation via Treesitter ───────────────────────────────
-- Walks the markdown parse tree for `atx_heading` nodes instead of relying on
-- vim's regex-based `]]`, so it stays correct inside fenced code blocks that
-- contain lines starting with `#`.
local function md_goto_heading(forward)
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "markdown")
  if not ok or not parser then
    return
  end
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.query.parse("markdown", "(atx_heading) @heading")
  local cur_row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local target
  for _, node in query:iter_captures(root, 0, 0, -1) do
    local row = node:range()
    if forward then
      if row > cur_row then
        target = row
        break
      end
    elseif row < cur_row then
      target = row
    else
      break
    end
  end
  if target then
    vim.api.nvim_win_set_cursor(0, { target + 1, 0 })
  end
end

-- ─── Markdown heading outline via Treesitter + Telescope ──────────────────────
-- Lists every `atx_heading` in the buffer (indented by level) so you can jump
-- straight to a section instead of stepping through them with ]#/[#.
local function md_headings_picker()
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "markdown")
  if not ok or not parser then
    return
  end
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.query.parse("markdown", "(atx_heading) @heading")
  local bufnr = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(bufnr)

  local entries = {}
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    local row = node:range()
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
    local level = #(line:match("^#+") or "#")
    local text = line:gsub("^#+%s*", "")
    table.insert(entries, { lnum = row + 1, display = string.rep("  ", level - 1) .. text, ordinal = text })
  end

  if #entries == 0 then
    vim.notify("No headings found", vim.log.levels.WARN)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Markdown Headings",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.ordinal,
          path = path,
          lnum = entry.lnum,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = conf.grep_previewer({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
      end)
      return true
    end,
  }):find()
end

-- ─── Markdown read-only preview split ──────────────────────────────────────────
-- Opens a scratch, read-only buffer in a vertical split mirroring the source
-- (so render-markdown.nvim renders it), live-synced on every edit, scrollbound
-- to the source window. Calling it again while open closes the split.
local function md_preview_toggle()
  local src_buf = vim.api.nvim_get_current_buf()
  local src_win = vim.api.nvim_get_current_win()

  -- Pressed from inside a preview (it is a markdown buffer too): close it
  -- instead of opening a preview of the preview.
  if vim.b[src_buf].md_preview_source then
    vim.api.nvim_win_close(src_win, true)
    return
  end

  local existing = vim.b[src_buf].md_preview_win
  if existing and vim.api.nvim_win_is_valid(existing) then
    vim.api.nvim_win_close(existing, true)
    vim.b[src_buf].md_preview_win = nil
    return
  end

  vim.cmd("vsplit")
  local preview_win = vim.api.nvim_get_current_win()
  local preview_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[preview_buf].filetype = "markdown"
  vim.bo[preview_buf].buftype = "nofile"
  vim.bo[preview_buf].swapfile = false
  vim.bo[preview_buf].bufhidden = "wipe"
  pcall(vim.api.nvim_buf_set_name, preview_buf,
    "Preview://" .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(src_buf), ":t"))
  vim.api.nvim_win_set_buf(preview_win, preview_buf)

  local function sync()
    if not vim.api.nvim_buf_is_valid(preview_buf) then
      return
    end
    local lines = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)
    vim.bo[preview_buf].modifiable = true
    vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, lines)
    vim.bo[preview_buf].modifiable = false
  end
  sync()
  vim.bo[preview_buf].readonly = true

  local group = ag("md_preview_" .. src_buf, { clear = true })
  au({ "TextChanged", "TextChangedI" }, {
    group = group,
    buffer = src_buf,
    callback = sync,
  })
  au("WinClosed", {
    group = group,
    pattern = tostring(preview_win),
    once = true,
    callback = function()
      vim.b[src_buf].md_preview_win = nil
      pcall(vim.api.nvim_del_augroup_by_id, group)
      -- Unbind the source window too, or it stays locked to whatever other
      -- scrollbound window exists after the preview is gone.
      if vim.api.nvim_win_is_valid(src_win) then
        vim.wo[src_win].scrollbind = false
        vim.wo[src_win].cursorbind = false
      end
    end,
  })

  vim.wo[src_win].scrollbind = true
  vim.wo[preview_win].scrollbind = true
  vim.wo[src_win].cursorbind = true
  vim.wo[preview_win].cursorbind = true

  vim.b[src_buf].md_preview_win = preview_win
  vim.b[preview_buf].md_preview_source = src_buf
  -- Keep editing in the source; the preview just follows it.
  vim.api.nvim_set_current_win(src_win)
end

au("FileType", {
  group = ag("markdown_treesitter_nav", { clear = true }),
  pattern = "markdown",
  callback = function()
    -- ]# / [# rather than ]h / [h (gitsigns' hunk navigation) or ]] / [[ (the
    -- built-in markdown ftplugin's regex section jumps).
    vim.keymap.set("n", "]#", function() md_goto_heading(true) end,
      { buffer = true, desc = "Next heading (treesitter)" })
    vim.keymap.set("n", "[#", function() md_goto_heading(false) end,
      { buffer = true, desc = "Prev heading (treesitter)" })
    vim.keymap.set("n", "<leader>mo", md_headings_picker,
      { buffer = true, desc = "Markdown headings outline" })
    vim.keymap.set("n", "<leader>mv", md_preview_toggle,
      { buffer = true, desc = "Toggle preview split" })
  end,
})
