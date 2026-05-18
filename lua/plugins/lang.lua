return {
  -- ──────────────────────────────────────────────────────────────────────────
  -- GO
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      lsp_cfg = false,      -- managed by LazyVim's gopls setup
      lsp_gofumpt = true,
      lsp_on_attach = false,
      dap_debug = true,
    },
    keys = {
      { "<leader>rt", "<cmd>GoTest<cr>",          ft = "go", desc = "Go test" },
      { "<leader>rr", "<cmd>GoRun<cr>",            ft = "go", desc = "Go run" },
      { "<leader>ri", "<cmd>GoImports<cr>",        ft = "go", desc = "Go imports" },
      { "<leader>rc", "<cmd>GoCoverage<cr>",       ft = "go", desc = "Go coverage" },
      { "<leader>rT", "<cmd>GoTestFunc<cr>",       ft = "go", desc = "Go test func under cursor" },
      { "<leader>ra", "<cmd>GoAddTag<cr>",         ft = "go", desc = "Go add struct tags" },
      { "<leader>re", "<cmd>GoIfErr<cr>",          ft = "go", desc = "Go if err" },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- RUST
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("expandMacro")
          end, { buffer = bufnr, desc = "Expand macro" })
          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, { buffer = bufnr, desc = "Open Cargo.toml" })
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, { buffer = bufnr, desc = "Runnables" })
          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { buffer = bufnr, desc = "Testables" })
          vim.keymap.set("n", "<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, { buffer = bufnr, desc = "Debuggables" })
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true, loadOutDirsFromCheck = true },
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- FLUTTER / DART
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    opts = {
      ui = { border = "rounded" },
      decorations = { statusline = { app_version = true, device = true } },
      lsp = {
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { vim.fn.expand("$HOME/.pub-cache") },
        },
      },
      debugger = { enabled = true, run_via_dap = true },
      flutter_path = nil, -- auto-detected from PATH
    },
    keys = {
      { "<leader>rr", "<cmd>FlutterRun<cr>",          ft = "dart", desc = "Flutter run" },
      { "<leader>rR", "<cmd>FlutterRestart<cr>",       ft = "dart", desc = "Flutter restart" },
      { "<leader>rs", "<cmd>FlutterStop<cr>",          ft = "dart", desc = "Flutter stop" },
      { "<leader>rd", "<cmd>FlutterDevices<cr>",       ft = "dart", desc = "Flutter devices" },
      { "<leader>re", "<cmd>FlutterEmulators<cr>",     ft = "dart", desc = "Flutter emulators" },
      { "<leader>rl", "<cmd>FlutterLogToggle<cr>",     ft = "dart", desc = "Flutter log" },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- PYTHON — extra tools on top of LazyVim extra
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    branch = "regexp",
    ft = "python",
    opts = { settings = { search = { my_venvs = { command = "fd python3 ~/.venv --full-path" } } } },
    keys = {
      { "<leader>rv", "<cmd>VenvSelect<cr>",    ft = "python", desc = "Select virtualenv" },
      { "<leader>rc", "<cmd>VenvSelectCached<cr>", ft = "python", desc = "Select cached venv" },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- TYPESCRIPT / NEXT.JS — extra tools
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {},
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- MARKDOWN
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
      heading = { sign = false },
      code = { sign = false },
    },
    ft = { "markdown", "Avante" },
    keys = {
      { "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    ft = "markdown",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = ""
    end,
    keys = {
      { "<leader>mb", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview in browser" },
    },
  },
}
