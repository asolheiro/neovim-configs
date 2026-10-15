return {
  -- ─── Which-key groups labels ──────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>v", group = "vim config" },
        { "<leader>s", group = "search/split" },
        { "<leader>t", group = "terminal" },
        { "<leader>d", group = "debug" },
        { "<leader>r", group = "run / REPL" },
        { "<leader>k", group = "kubernetes" },
        { "<leader>m", group = "markdown" },
      },
    },
  },

  -- ─── Better search/jump: flash.nvim (LazyVim default, keep) ─────────────
  { "folke/flash.nvim", opts = { modes = { search = { enabled = false } } } },

  -- ─── File explorer tweaks ────────────────────────────────────────────────
  -- Snacks explorer (<leader>e) aberto por padrão como sidebar, estilo VS Code.
  {
    "folke/snacks.nvim",
    init = function()
      local function explorers()
        return Snacks.picker.get({ source = "explorer" })
      end

      -- abre ao iniciar com arquivo(s) como argumento; `nvim .` já abre via replace_netrw
      -- e `nvim` sem argumentos fica com o dashboard
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("explorer_on_start", { clear = true }),
        once = true,
        callback = function()
          if #vim.api.nvim_list_uis() == 0 or vim.o.diff or vim.fn.argc() == 0 then return end
          local ft = vim.bo.filetype
          if ft == "gitcommit" or ft == "gitrebase" or ft == "man" or vim.bo.buftype ~= "" then return end
          if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then return end
          vim.schedule(function()
            -- enter = false: abre a sidebar sem tirar o foco do arquivo
            if #explorers() == 0 then Snacks.explorer({ enter = false }) end
          end)
        end,
      })

      -- fechar a última janela de edição (:q, :wq) sai do nvim em vez de deixar só o explorer
      local explorer_ft = { snacks_layout_box = true, snacks_picker_list = true, snacks_picker_input = true }
      vim.api.nvim_create_autocmd("WinClosed", {
        group = vim.api.nvim_create_augroup("explorer_quit", { clear = true }),
        callback = function()
          vim.schedule(function()
            if #explorers() == 0 then return end
            for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              local is_float = vim.api.nvim_win_get_config(w).relative ~= ""
              if not is_float and not explorer_ft[vim.bo[vim.api.nvim_win_get_buf(w)].filetype] then return end
            end
            if #vim.api.nvim_list_tabpages() > 1 then vim.cmd("tabclose") else vim.cmd("quitall") end
          end)
        end,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { width = 35 },
      filesystem = {
        -- o Snacks explorer é quem abre diretórios (`nvim .`); Neo-tree fica só no :Neotree
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },

  -- ─── Git blame inline ────────────────────────────────────────────────────
  {
    "f-person/git-blame.nvim",
    event = "BufReadPost",
    config = function()
      vim.g.gitblame_display_virtual_text = 1
      vim.g.gitblame_message_template = "  <author> • <date> • <summary>"
      vim.g.gitblame_date_format = "%d/%m/%y"
      vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle git blame" })
    end,
  },

  -- ─── Auto-close pairs ────────────────────────────────────────────────────
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = { check_ts = true } },

  -- ─── Highlight TODO/FIXME/HACK comments ──────────────────────────────────
  {
    "folke/todo-comments.nvim",
    opts = { signs = true },
  },

  -- ─── Better quickfix list ─────────────────────────────────────────────────
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- ─── tmux / wezterm / kitty navigation passthrough ───────────────────────
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Go to left window / tmux pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Go to lower window / tmux pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Go to upper window / tmux pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right window / tmux pane" },
    },
  },

  -- ─── Diffview for git ─────────────────────────────────────────────────────
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",           desc = "Diff view open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>",          desc = "Diff view close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",  desc = "File history" },
    },
  },
}
