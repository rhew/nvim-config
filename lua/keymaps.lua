local map = require("utils").map

-- switch windows when in a terminal
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- remaps to keep centered after search or join
map("t", "n", "nzzzv")
map("t", "N", "Nzzzv")
map("t", "J", "mzJ`z")

-- move selected text. gv is highlight, = is re-indent
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- my todo list: move line under cursor to another section
map("n", "<leader>tc", "dd/^# CHORES<CR>jp<C-o>")
map("n", "<leader>td", "dd/^# DONE<CR>jp<C-o>")
map("n", "<leader>ti", "dd/^# INBOX<CR>jp<C-o>")
map("n", "<leader>to", "dd/^# OUTBOX<CR>jp<C-o>")
map("n", "<leader>tp", "dd/^# PAUSE<CR>jp<C-o>")
map("n", "<leader>tt", "dd/^# TODO<CR>jp<C-o>")
