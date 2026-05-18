-- Custom keymaps (LazyVim already binds many via which-key)
local map = vim.keymap.set

-- ─── Escape shortcuts ─────────────────────────────────────────────────────────
map("i", "jk", "<ESC>", { silent = true })
map("i", "kj", "<ESC>", { silent = true })

-- ─── Stay centered when scrolling / searching ─────────────────────────────────
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- ─── Better paste (don't overwrite register) ──────────────────────────────────
map("x", "p", '"_dP')

-- ─── Move lines up/down ───────────────────────────────────────────────────────
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
map("n", "<A-j>", ":m .+1<CR>==",     { silent = true })
map("n", "<A-k>", ":m .-2<CR>==",     { silent = true })

-- ─── Indent keep selection ────────────────────────────────────────────────────
map("v", "<", "<gv")
map("v", ">", ">gv")

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
