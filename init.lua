vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoindent = false
vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.indentexpr = ""

-- line numbers, but not for terminal mode
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END
]]

-- https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
-- FINDING FILES:
-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
vim.opt.path:append("**")

-- :find  Display all matching files when we tab complete
vim.opt.wildmenu = true
vim.opt.wildignore:append("**/*.pyc")
vim.opt.wildignore:append("**/.git/*")
vim.opt.wildmode = "longest,list,full"

vim.g.mapleader = " "

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

require('plugins')
