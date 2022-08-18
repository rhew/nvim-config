require'toggleterm'.setup {
  open_mapping = [[<C-\>]]
}

vim.keymap.set('v', '<C-\\>', [[:ToggleTermSendVisualSelection<CR>]])
vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]])
