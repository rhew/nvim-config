set tabstop=4 softtabstop=4 expandtab shiftwidth=4
set incsearch
set scrolloff=8
set nobackup nowritebackup
set splitbelow splitright
set noautoindent nocindent nosmartindent indentexpr=
" disable auto-comment
set formatoptions-=cro

" https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" :find  Display all matching files when we tab complete
set wildmenu
set wildignore+=**/*.pyc
set wildignore+=**/.git/*
set wildmode=longest,list,full


" vim remaps

let mapleader = " "
" switch windows when in a terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
" remaps to keep centered after search or join
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" move highlighted text. gv is highlight, = is re-indent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" my todo list: move line under cursor to another section
nnoremap <leader>tc dd/^# CHORES<CR>jp<C-o>
nnoremap <leader>td dd/^# DONE<CR>jp<C-o>
nnoremap <leader>ti dd/^# INBOX<CR>jp<C-o>
nnoremap <leader>to dd/^# OUTBOX<CR>jp<C-o>
nnoremap <leader>tp dd/^# PAUSE<CR>jp<C-o>
nnoremap <leader>tt dd/^# TODO<CR>jp<C-o>


" plugins
" Install vim-plug manager: https://github.com/junegunn/vim-plug#installation
call plug#begin('~/.config/nvim/plugged')
    " gruvbox: just a color scheme. pretty
    Plug 'gruvbox-community/gruvbox'

    " lsp
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'neovim/nvim-lspconfig' " Start language servers

    " nvim-cmp et. al.: Add autocomplete, hover, signature help
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'

    " java refactoring
    " recommended by jdtls: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#jdtls
    " Plug 'mfussenegger/nvim-jdtls'

    " telescope: nice list view/preview for symbols, files, greps, etc.
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " ALE: use whatever linters are available for the current buffer file type
    Plug 'dense-analysis/ale'

    " Fugitive: git. probably don't need this.
    Plug 'tpope/vim-fugitive'

    " Dev icons: Assumes a patched font. Telescope and completion plugins use
    " them. pretty
    Plug 'kyazdani42/nvim-web-devicons'

    " markdown-preview: render markdown buffer (including planUML!) in browser
    " :MarkdownPreview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " limelight: highligting by space gaps. pretty
    " <leader> h toggles
    Plug 'junegunn/limelight.vim'

    " Screenplay syntax: probably don't need this anymore
    Plug 'vim-scripts/fountain.vim'

    " HTTP syntax and client (cURL): send current buffer as HTTP request and
    " put response in a new buffer.
    " :Http sends the current .http buffer
    Plug 'nicwest/vim-http'

    " Automagic tabs vs. spaces. Why does go fmt use tabs?? :(
    Plug 'tpope/vim-sleuth'

    " TODO floaterm vim-test projectionist
call plug#end()


"""
" gruvbox config
"""

" colorscheme must come before other coloring options like spell and lsp
colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE


" spell
set spell spelllang=en_us
syn match myExCapitalWords +\<[A-Z]\w*\>+ contains=@NoSpell


" Mac specific plantuml viewer
" Use :PlantUML or <leader> P:
command! -range PlantUML execute ':<line1>,<line2> w !plantuml -pipe | open -a Preview.app -f'
map <leader>pu :PlantUML<CR>


"""
" nvim-lsp-installer
" nvim-lspconfig
"""

lua require("nvim-lsp-installer").setup {}

lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.dockerls.setup{}
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.terraformls.setup{}
lua require'lspconfig'.zk.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.yamlls.setup{}
lua require'lspconfig'.jdtls.setup{}
lua require'lspconfig'.pylsp.setup{}


"""
" Completion
"""

lua << ENDLUA
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
ENDLUA


" nvim-lua/completion-nvim recommended settings
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c


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


"""
" Telescope config
"""

lua << EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {"vendor"} } }
EOF

" override default word selection binding
nnoremap z= <cmd>Telescope spell_suggest<cr>

" https://github.com/nvim-telescope/telescope.nvim#pickers
nnoremap <leader>ff <cmd>Telescope find_files<cr>
" mac: brew install rg
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" lsp pickers

nnoremap <Leader>fd :lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap <Leader>fi :lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap <Leader>fr :lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap <Leader>fs :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
nnoremap <Leader>fca :lua require'telescope.builtin'.lsp_code_actions{}<cr>
nnoremap <Leader>fwd :lua require'telescope.builtin'.lsp_workspace_diagnostics{}<cr>

" git pickers

nnoremap <Leader>fgs :lua require'telescope.builtin'.git_status{}<cr>
nnoremap <Leader>fgc :lua require'telescope.builtin'.git_commits{}<cr>

"""
" dense-analyss/ale options
"""

map <leader>at :ALEToggle<CR>
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length: {max: 100}}}"'
let b:ale_fix_on_save = 0

"""
" markdown-preview options
"""
let g:mkdp_browser = 'Firefox'


"""
" Limelight config
"""
let g:limelight_conceal_ctermfg = 'darkgray'
nmap <Leader>h :Limelight!!<CR>

"""
" Fountain config
"""
au BufRead,BufNewFile *.fountain set filetype=fountain

"""
" vim-http config
"""
" don't create a new buffer for each request
let g:vim_http_tempbuffer = 1
