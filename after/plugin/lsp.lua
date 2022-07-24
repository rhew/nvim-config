require("nvim-lsp-installer").setup {}

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
  sources = { -- ordered by priority
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer   = "[buf]",
        nvim_lsp = "[LSP]",
        path     = "[path]",
      }
    }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- TODO convert to lua
-- nvim-lua/completion-nvim recommended settings
-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd [[
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]]

-- Set completeopt to have a better completion experience
vim.cmd [[
  set completeopt=menuone,noinsert,noselect
]]

-- Avoid showing message extra message when using completion
vim.cmd [[
  set shortmess+=c
]]

vim.cmd [[
  nnoremap <C-]> :lua vim.lsp.buf.definition()<CR>
  nnoremap gd :lua vim.lsp.buf.definition()<CR>
  nnoremap <leader>li :lua vim.lsp.buf.implementation()<CR>
  nnoremap <leader>lsh :lua vim.lsp.buf.signature_help()<CR>
  nnoremap <leader>lrn :lua vim.lsp.buf.rename()<CR>
  nnoremap <leader>lh :lua vim.lsp.buf.hover()<CR>
  nnoremap <leader>lca :lua vim.lsp.buf.code_action()<CR>
  nnoremap <leader>lsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
  nnoremap <leader>ln :lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <leader>lp :lua vim.lsp.diagnostic.goto_prev()<CR>
  " nnoremap <leader>lll :call LspLocationList()<CR>
]]
