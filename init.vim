set tabstop=4 softtabstop=4 expandtab shiftwidth=4
set incsearch
set scrolloff=8
set nobackup nowritebackup
set splitbelow splitright

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
" faster windowing
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
" remaps to keep centered after search or join
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" move highlighted text. gv is highlight, = is re-indent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


call plug#begin('~/.config/nvim/plugged')
"lsp
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'


Plug 'gruvbox-community/gruvbox'

Plug 'nvim-lua/completion-nvim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()


"""
" gruvbox config
"""

colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

"""
" lsp/completion config
"""

lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}


" create a local list of errors when opening a buffer. :lnext :lprev :lopen
fun! LspLocationList()
    lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfun
augroup JAMES_LSP
    autocmd!
    autocmd! BufWrite,BufEnter,InsertLeave * call LspLocationList()
augroup END


" nvim-lua/completion-nvim recommended settings
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

" lsp mappings
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>vll :call LspLocationList()<CR>

"""
" Telescope config
"""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fr :lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap <Leader>fs :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
nnoremap <Leader>fa :lua require'telescope.builtin'.lsp_code_actions{}<cr>
vnoremap <Leader>fa :lua require'telescope.builtin'.lsp_range_code_actions{}<cr>
