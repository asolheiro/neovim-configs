return {
  -- ─── Which-key groups labels ──────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>v", group = "vim config" },
        { "<leader>s", group = "split/window" },
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { width = 35 },
      filesystem = {
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
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
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
