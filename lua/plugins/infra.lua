return {
  -- ──────────────────────────────────────────────────────────────────────────
  -- KUBERNETES / HELM
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml" },
  },
  {
    "mrjosh/helm-ls",       -- helm LSP
    ft = "helm",
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- YAML (LazyVim extra already adds yaml-language-server; this adds k8s schemas)
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"]     = "/.github/workflows/*.{yml,yaml}",
                ["https://json.schemastore.org/github-action.json"]       = "action.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*compose*.{yml,yaml}",
                ["https://json.schemastore.org/helmfile.json"]            = "helmfile.{yml,yaml}",
                kubernetes = { "/*.yaml", "/*.yml" },
              },
              schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
              validate = true,
              completion = true,
              hover = true,
            },
          },
        },

        -- ── Docker LSP ───────────────────────────────────────────────────
        dockerls = {},
        docker_compose_language_service = {},

        -- ── Helm ─────────────────────────────────────────────────────────
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              yamlls = { path = "yaml-language-server" },
            },
          },
        },
      },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- TERRAFORM / OpenTofu
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "tf", "hcl" },
    init = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- KUBERNETES LIVE OPS (kubectl from inside nvim)
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "arjunmahishi/k8s.nvim",
    cmd = { "K8sListPods", "K8sDescribePod", "K8sGetNamespaces" },
    opts = {},
    keys = {
      { "<leader>kp", "<cmd>K8sListPods<cr>",        desc = "K8s list pods" },
      { "<leader>kn", "<cmd>K8sGetNamespaces<cr>",   desc = "K8s namespaces" },
      { "<leader>kd", "<cmd>K8sDescribePod<cr>",     desc = "K8s describe pod" },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- FORMATTING (conform.nvim — LazyVim includes it, just add formatters)
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go         = { "goimports", "gofumpt" },
        python     = { "ruff_format", "ruff_organize_imports" },
        rust       = { "rustfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier", "markdownlint-cli2" },
        css        = { "prettier" },
        html       = { "prettier" },
        dart       = { "dart_format" },
        sh         = { "shfmt" },
        terraform  = { "terraform_fmt" },
        lua        = { "stylua" },
      },
    },
  },

  -- ──────────────────────────────────────────────────────────────────────────
  -- MASON: ensure formatters and LSPs are installed
  -- ──────────────────────────────────────────────────────────────────────────
  {
    "mason-org/mason.nvim",
    -- As extras do LazyVim já adicionam várias ferramentas (goimports, gofumpt,
    -- delve, stylua, shfmt, codelldb...). O LazyVim não deduplica a lista e
    -- instalar o mesmo pacote duas vezes quebra com "Package is already installing",
    -- por isso a lista final é deduplicada aqui.
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSPs
        "gopls", "pyright", "ruff", "rust-analyzer",
        "typescript-language-server", "dart-debug-adapter",
        "yaml-language-server", "dockerfile-language-server",
        "docker-compose-language-service", "helm-ls",
        "lua-language-server", "marksman", "taplo",
        -- Formatters
        "goimports", "gofumpt", "prettier", "stylua", "shfmt",
        -- DAP
        "delve", "debugpy", "codelldb",
      })
      local seen = {}
      opts.ensure_installed = vim.tbl_filter(function(tool)
        if seen[tool] then return false end
        seen[tool] = true
        return true
      end, opts.ensure_installed)
    end,
  },
}
