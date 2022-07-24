require('telescope').setup{ defaults = { file_ignore_patterns = {"vendor"} } }

-- TODO: port to lua
vim.cmd [[
    " override default word selection binding
    nnoremap z= <cmd>Telescope spell_suggest<cr>

    " https://github.com/nvim-telescope/telescope.nvim#pickers
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    " mac: brew install rg
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>

    " lsp pickers

    nnoremap <Leader>fd :lua require'telescope.builtin'.lsp_definitions{}<cr>
    nnoremap <Leader>fi :lua require'telescope.builtin'.lsp_implementations{}<cr>
    nnoremap <Leader>fr :lua require'telescope.builtin'.lsp_references{}<cr>
    nnoremap <Leader>fs :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
    nnoremap <Leader>fca :lua require'telescope.builtin'.lsp_code_actions{}<cr>
    nnoremap <Leader>fwd :lua require'telescope.builtin'.lsp_workspace_diagnostics{}<cr>

    " git pickers

    nnoremap <Leader>fgs :lua require'telescope.builtin'.git_status{}<cr>
    nnoremap <Leader>fgc :lua require'telescope.builtin'.git_commits{}<cr>
]]
