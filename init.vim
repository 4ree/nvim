syntax on
set number
set cursorline
set cursorlineopt=number
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent


" Fold
set foldmethod=syntax
set foldlevel=1
set foldnestmax=1
set encoding=utf8

" Search
set hlsearch
nnoremap i :nohls<CR>i

" Plugin
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sainnhe/everforest'

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

call plug#end()

"Color scheme
set background=dark
colorscheme everforest


"Open NERDTree
:nnoremap <silent> <expr> <F2> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

"Coc.nvim
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

"Autocomplete with the first option if pop up menu is open.
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" Comments
let mapleader = ","

" remap save
nnoremap <space> :w<CR>

" moving between windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-Left> <C-W>h
nnoremap <C-Down> <C-W>j
nnoremap <C-Up> <C-W>k
nnoremap <C-Right> <C-W>l
nnoremap <leader>o :tabonly<CR>

set clipboard+=unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P


" FZF key mapping
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>w :Rg <C-R><C-W><CR>

filetype plugin on
set splitright
set splitbelow



" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"


function! IBusOff()
    " Lưu engine hiện tại
    let g:ibus_prev_engine = system('ibus engine')
    " Chuyển sang engine tiếng Anh
    " Nếu bạn thấy cái cờ ở đây
    " khả năng là font của bạn đang render emoji lung tung...
    " xkb : us :: eng (không có dấu cách)
    silent! execute '!ibus engine xkb🇺🇸:eng'
endfunction



function! IBusOn()
    let l:current_engine = system('ibus engine')
    " nếu engine được set trong normal mode thì
    " lúc vào insert mode duùn luôn engine đó
    if l:current_engine !~? 'xkb🇺🇸:eng'
        let g:ibus_prev_engine = l:current_engine
    endif
    " Khôi phục lại engine
    silent! execute '!ibus engine ' . g:ibus_prev_engine
endfunction

augroup IBusHandler
    " Khôi phục ibus engine khi tìm kiếm
    autocmd CmdLineEnter [/?] silent call IBusOn()
    autocmd CmdLineLeave [/?] silent call IBusOff()
    autocmd CmdLineEnter \? silent call IBusOn()
    autocmd CmdLineLeave \? silent call IBusOff()
    " Khôi phục ibus engine khi vào insert mode
    autocmd InsertEnter * silent call IBusOn()
    " Tắt ibus engine khi vào normal mode
    autocmd InsertLeave * silent call IBusOff()
augroup END

silent call IBusOff()

"Language tool
let b:ale_linter_aliases = ['tex', 'text']
let g:ale_languagetool_executable = "java"
let g:ale_languagetool_options = "-jar /data/runtimes/languagetool/languagetool-commandline.jar --languagemodel /data/runtimes/languagemodel/ --word2vecmodel /data/runtimes/word2vec/ --disable WHITESPACE_RULE,COMMA_PARENTHESIS_WHITESPACE,CURRENCY[1]"
let g:ale_disable_lsp = 1
set signcolumn=number
map <F3> :ALEToggle<CR>
