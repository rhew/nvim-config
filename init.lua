-- Core view
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.winborder = "rounded"
vim.g.have_nerd_font = true

-- Core behavior
vim.opt.ts = 4
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.g.mapleader = " "
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.spell = true
vim.opt.spelllang = "en"

-- Don't warn on Lua config files for Neovim
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- enable treesitter highlighting when opening a file ¯\_(ツ)_/¯
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if pcall(vim.treesitter.get_parser, args.buf, ft) then
      vim.treesitter.start(args.buf, ft)
    end
  end,
})

--- core keymaps
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { scope = "line" })
end, { desc = "Line diagnostics (float)" })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
  { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>",
  { desc = "Next diagnostic" })
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, {
  desc = "LSP definition",
})
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP rename symbol" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Packages and configuration
vim.pack.add({
  {src = "https://github.com/nvim-treesitter/nvim-treesitter"},
  {src = "https://github.com/echasnovski/mini.pick"},
  -- just to start and attach installed language servers
  {src = "https://github.com/neovim/nvim-lspconfig"},
  {src = "https://github.com/mason-org/mason.nvim"},
  {src = "https://github.com/mason-org/mason-lspconfig.nvim"},
  {src = "https://github.com/tpope/vim-sleuth"},
  {src = "https://github.com/davidbeckingsale/writegood.vim"},
  {src = "https://github.com/Exafunction/codeium.vim"},
  {src = "https://github.com/junegunn/vim-easy-align"},
  {src = "https://github.com/lewis6991/gitsigns.nvim"},
})

-- mini.pick configuration
require "mini.pick".setup()
vim.keymap.set('n', '<leader>sf', ":Pick files<CR>")
vim.keymap.set('n', '<leader>sg', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader>sh', ":Pick help<CR>")

-- mason mason-lspconig configuration
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "gopls",
        "lua_ls",
        "pyright",
    },
})

-- writegood configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.cmd("WritegoodEnable")
  end,
})

-- codium configuration
vim.api.nvim_create_autocmd('BufEnter', {
  once = true,
  callback = function()
    vim.g.codeium_enabled = false
    vim.keymap.set(
      'n',
      '<leader>ai',
      '<Cmd>CodeiumToggle<CR>',
      { desc = 'Toggle Codeium' }
    )
  end,
})

-- vim-easy-align configuration
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

-- gitsigns configuration
require('gitsigns').setup({
  signs = {
    change = { text = '~' },
  },
})
