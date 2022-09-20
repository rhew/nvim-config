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
vim.wo.spell = true
vim.opt.spelllang = "en_us"
vim.opt.laststatus = 3

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

-- enable markdown folding -- todo: required buffer reload; toggle back doesn't work
vim.keymap.set("n", "<Leader>zm", function() vim.g.markdown_folding = not(vim.g.markdown_folding) end )
-- next and previous fold
vim.keymap.set("n", "<Leader>zj", "zczjzoz<CR>")
vim.keymap.set("n", "<Leader>zk", "zczkzozkjz<CR>")
