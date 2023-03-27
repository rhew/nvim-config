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
    "lua",
    "markdown",
    "python",
    "terraform",
    "vim",
    "yaml",
  },
}
