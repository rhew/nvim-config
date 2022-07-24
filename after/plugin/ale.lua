local map = require("utils").map
map ("n", "<leader>at", ":ALEToggle<CR>")
vim.g.ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length: {max: 100}}}"'
vim.b.ale_fix_on_save = 0
