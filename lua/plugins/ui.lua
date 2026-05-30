return {
  -- ─── Colorscheme: tokyonight (LazyVim default — keep, just pin options) ──
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
    },
  },

  -- ─── Statusline customization ─────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add LSP server name to statusline
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return "" end
          local names = {}
          for _, c in ipairs(clients) do
            if c.name ~= "copilot" then
              table.insert(names, c.name)
            end
          end
          return " " .. table.concat(names, ", ")
        end,
        color = { fg = "#7aa2f7" },
      })
      return opts
    end,
  },

  -- ─── Bufferline: show modified indicator ─────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" },
        },
      },
    },
  },

  -- ─── Indent guides ────────────────────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { show_start = false, show_end = false },
    },
  },

  -- ─── Smooth scrolling ─────────────────────────────────────────────────────
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    opts = { mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" } },
  },

  -- ─── Dashboard ────────────────────────────────────────────────────────────
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
      ███╗   ██╗██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██║   ██║██║████╗ ████║
      ██╔██╗ ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      opts.config = opts.config or {}
      opts.config.header = vim.split(logo, "\n")
      return opts
    end,
  },

  -- ─── Notifications ────────────────────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width  = function() return math.floor(vim.o.columns * 0.75) end,
    },
  },

  -- ─── Color preview for CSS/hex values ────────────────────────────────────
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { user_default_options = { mode = "background", tailwind = true } },
  },
}
