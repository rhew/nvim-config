require('telescope').setup{ defaults = { file_ignore_patterns = {"vendor"} } }

local map = require("utils").map

-- override default word selection binding
map("n", "z=", "<cmd>Telescope spell_suggest<cr>")

-- https://github.com/nvim-telescope/telescope.nvim#pickers
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")

-- mac: brew install rg
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- lsp pickers
map("n", "<Leader>fd", ":lua require'telescope.builtin'.lsp_definitions{}<cr>")
map("n", "<Leader>fi", ":lua require'telescope.builtin'.lsp_implementations{}<cr>")
map("n", "<Leader>fr", ":lua require'telescope.builtin'.lsp_references{}<cr>")
map("n", "<Leader>fs", ":lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>")
map("n", "<Leader>fca", ":lua require'telescope.builtin'.lsp_code_actions{}<cr>")
map("n", "<Leader>fwd", ":lua require'telescope.builtin'.lsp_workspace_diagnostics{}<cr>")

-- git pickers
map("n", "<Leader>fgs", ":lua require'telescope.builtin'.git_status{}<cr>")
map("n", "<Leader>fgc", ":lua require'telescope.builtin'.git_commits{}<cr>")
