require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  ensure_installed = {
    "bash",
    "c",
    "dockerfile",
    "go",
    "help",
    "jsonnet",
    "lua",
    "markdown",
    "python",
    "terraform",
    "vim",
    "yaml",
  },
}

local jsonnet_ft =  vim.api.nvim_create_augroup('jsonnet_ft', {})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = jsonnet_ft,
  pattern = '*.libsonnet',
  -- TODO: convert to Lua
  command = "set filetype=jsonnet",
})
