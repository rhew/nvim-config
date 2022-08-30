local toggleterm_resize_function = function()

  local direction = (vim.api.nvim_win_get_width(0) > vim.api.nvim_win_get_height(0) * 2 and 'vertical' or 'horizontal')
  local size = (direction == 'horizontal' and 15 or vim.o.columns * 0.4)

  require'toggleterm'.setup {
    open_mapping = [[<C-\>]],
    direction = direction,
    size = size
  }

end

toggleterm_resize_function()

-- TODO: This still requires a vim restart
local toggleterm_group =  vim.api.nvim_create_augroup('toggleterm_group', {})
vim.api.nvim_create_autocmd({"VimResized"}, {
  group = toggleterm_group,
  pattern = '*',
  callback = toggleterm_resize_function,
})

-- <C-\>
-- Send selected text to terminal 1
vim.keymap.set('v', '<C-\\>', ':ToggleTermSendVisualSelection<CR>')

-- :T 4
-- send selected text to terminal 4
-- TODO; Figure out how to pass count in a map to a command.
vim.cmd [[cnoreabbrev T ToggleTermSendVisualSelection]]
