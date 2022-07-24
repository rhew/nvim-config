vim.g.limelight_conceal_ctermfg = 'darkgray'

local map = require("utils").map
map("n", "<Leader>h", ":Limelight!!<CR>")
