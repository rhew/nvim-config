local map = require("utils").map

map ("n", "<leader>at", ":ALEToggle<CR>")
vim.b.ale_fix_on_save = 0

-- YAML
vim.g.ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length: {max: 100}}}"'

-- GoLang
vim.cmd [[
  let g:ale_linters = {'go': ['gofmt', 'golint', 'gopls', 'govet', 'golangci-lint'] }
]]
vim.g.ale_go_golangci_lint_options = ''
