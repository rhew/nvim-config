-- line numbers, but not for terminal mode

vim.opt.number = true
vim.opt.relativenumber = true

local number_toggle_group =  vim.api.nvim_create_augroup('number_toggle_group', {})
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
  group = number_toggle_group,
  pattern = '*',
  -- TODO: convert these commands to native Lua
  command = "if &nu && mode() != \"i\" | set rnu | endif",
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
  group = number_toggle_group,
  pattern = '*',
  command = "if &nu | set nornu | endif",
})
vim.api.nvim_create_autocmd({"TermOpen"}, {
  group = number_toggle_group,
  pattern = '*',
  command = "setlocal nonumber norelativenumber",
})
