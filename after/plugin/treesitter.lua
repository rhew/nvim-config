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
    "python",
    "terraform",
    "vim",
    "yaml",
  },
}
