-- Custom keymaps (LazyVim already binds many via which-key)
local map = vim.keymap.set

-- ─── Escape shortcuts ─────────────────────────────────────────────────────────
map("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
map("i", "kj", "<ESC>", { silent = true, desc = "Exit insert mode" })

-- ─── Stay centered when scrolling / searching ─────────────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n",     "nzzzv", { desc = "Next search result (centered)" })
map("n", "N",     "Nzzzv", { desc = "Prev search result (centered)" })

-- ─── Better paste (don't overwrite register) ──────────────────────────────────
map("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- ─── Move lines up/down ───────────────────────────────────────────────────────
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("n", "<A-j>", ":m .+1<CR>==",     { silent = true, desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==",     { silent = true, desc = "Move line up" })

-- ─── Indent keep selection ────────────────────────────────────────────────────
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- ─── Window management ────────────────────────────────────────────────────────
map("n", "<leader>sv", "<C-w>v",  { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s",  { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=",  { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- ─── Buffer ───────────────────────────────────────────────────────────────────
map("n", "<leader>bd", "<cmd>bdelete<cr>",          { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>",       { desc = "Delete all other buffers" })

-- ─── Quickfix ─────────────────────────────────────────────────────────────────
map("n", "<leader>co", "<cmd>copen<cr>",  { desc = "Open quickfix" })
map("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix" })
map("n", "]q", "<cmd>cnext<cr>",          { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>",          { desc = "Prev quickfix" })

-- ─── Config shortcuts ─────────────────────────────────────────────────────────
map("n", "<leader>vc", "<cmd>e $MYVIMRC<cr>",        { desc = "Edit init.lua" })
map("n", "<leader>vl", "<cmd>e ~/.config/nvim/lua/config/lazy.lua<cr>", { desc = "Edit lazy.lua" })
