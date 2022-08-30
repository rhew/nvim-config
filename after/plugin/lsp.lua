require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "dockerls",
    "gopls",
    "terraformls",
    "vimls",
    "yamlls",
    -- "jdtls",
    "pylsp",
    "sumneko_lua",
    "lua-language-server"
  }
})

require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.sumneko_lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      }
    }
  }
}

-- Completion
local cmp = require "cmp"
local lspkind = require('lspkind')
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  snippet = {
    expand = function(args)
      require'luaasnip'.lsp_expand(args.body)
    end
  },
  sources = { -- ordered by priority
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer   = "[buf]",
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        path     = "[path]",
      }
    }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local map = require("utils").map

-- nvim-lua/completion-nvim recommended settings
-- Use <Tab> and <S-Tab> to navigate through popup menu
map("i", "<expr> <Tab>", "pumvisible() ? \"<C-n>\" : \"<Tab>\"")
map("i", "<expr> <S-Tab>", "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"")

-- Set compileteopt to have a better completion experience
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.opt.shortmess:append("c")

map("n", "<C-]>", ":lua vim.lsp.buf.definition()<CR>")
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>lsh", ":lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>lrn", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>lca", ":lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>lsd", ":lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>")
map("n", "<leader>ln", ":lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", "<leader>lp", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
-- nnoremap <leader>lll :call LspLocationList()<CR>
