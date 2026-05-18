return {
  -- ToggleTerm (LazyVim includes it; we just extend with extra configs)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15
        elseif term.direction == "vertical" then return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      float_opts = { border = "curved" },
    },
    keys = {
      { "<C-\\>",     desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Float terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Vertical terminal" },
      {
        "<leader>tg",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            float_opts = { border = "double" },
            on_open = function(t)
              vim.cmd("startinsert!")
              vim.api.nvim_buf_set_keymap(t.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
          })
          lazygit:toggle()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>tp",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local py = Terminal:new({ cmd = "python3", direction = "horizontal" })
          py:toggle()
        end,
        ft = "python",
        desc = "Python REPL",
      },
    },
  },
}
