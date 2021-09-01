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


" plugins
" Install vim-plug manager: https://github.com/junegunn/vim-plug#installation
call plug#begin('~/.config/nvim/plugged')
" gruvbox
Plug 'gruvbox-community/gruvbox'

" lsp and completion
Plug 'neovim/nvim-lspconfig' " Start language servers
Plug 'kabouzeid/nvim-lspinstall' " Add :LspInstall <tab for list>
Plug 'nvim-lua/completion-nvim' " Add autocomplete, hover, signature help
" java refactoring
" recommended by jdtls: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#jdtls
" Plug 'mfussenegger/nvim-jdtls'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" ALE
Plug 'dense-analysis/ale'
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
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline ctermfg=red
hi SpellCap cterm=underline ctermfg=red
hi SpellLocal cterm=underline ctermfg=red
hi SpellRare cterm=underline ctermfg=red


" Mac specific plantuml viewer
" Use :PlantUML or <leader> P:
command! -range PlantUML execute ':<line1>,<line2> w !plantuml -pipe | open -a Preview.app -f'
map <leader>pu :PlantUML<CR>


"""
" kabouzeid/nvim-lspinstall  and nvim-lua/completion-nvim config
"""

lua << ENDLUA
-- Register configs for installed servers in lspconfig.
require'lspinstall'.setup()

-- Get list of installed servers and then setup each
-- server with lspconfig as usual.
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{on_attach=require'completion'.on_attach}
end
ENDLUA

" yamlls doesn't start with the above code :(
lua require'lspconfig'.yamlls.setup{on_attach=require'completion'.on_attach}

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


nnoremap <leader>ld :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>li :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>lsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>lrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>lrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>lh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>lca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>lsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>ln :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>lll :call LspLocationList()<CR>


"""
" Telescope config
"""

" https://github.com/nvim-telescope/telescope.nvim#pickers
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>  " mac: brew install rg

" lsp pickers

nnoremap <Leader>fd :lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap <Leader>fi :lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap <Leader>fr :lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap <Leader>fws :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
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
