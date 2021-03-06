syntax on
set number
set cursorline
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
Plug  'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cocopon/iceberg.vim'
Plug 'kevinhwang91/nvim-bqf' 
call plug#end()

"Color scheme
colorscheme iceberg
set background=light


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
"inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
nnoremap <leader>e :CocCommand snippets.editSnippets<CR>

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


function! IBusOff()
    " L??u engine hi???n t???i
    let g:ibus_prev_engine = system('ibus engine')
    " Chuy???n sang engine ti???ng Anh
    " N???u b???n th???y c??i c??? ??? ????y
    " kh??? n??ng l?? font c???a b???n ??ang render emoji lung tung...
    " xkb : us :: eng (kh??ng c?? d???u c??ch)
    silent! execute '!ibus engine xkb????????:eng'
endfunction



function! IBusOn()
    let l:current_engine = system('ibus engine')
    " n???u engine ???????c set trong normal mode th??
    " l??c v??o insert mode du??n lu??n engine ????
    if l:current_engine !~? 'xkb????????:eng'
        let g:ibus_prev_engine = l:current_engine
    endif
    " Kh??i ph???c l???i engine
    silent! execute '!ibus engine ' . g:ibus_prev_engine
endfunction

augroup IBusHandler
    " Kh??i ph???c ibus engine khi t??m ki???m
    autocmd CmdLineEnter [/?] silent call IBusOn()
    autocmd CmdLineLeave [/?] silent call IBusOff()
    autocmd CmdLineEnter \? silent call IBusOn()
    autocmd CmdLineLeave \? silent call IBusOff()
    " Kh??i ph???c ibus engine khi v??o insert mode
    autocmd InsertEnter * silent call IBusOn()
    " T???t ibus engine khi v??o normal mode
    autocmd InsertLeave * silent call IBusOff()
augroup END

silent call IBusOff()

"Language tool
let b:ale_linter_aliases = ['tex', 'text', 'html']
let g:ale_languagetool_executable = "java"
let g:ale_languagetool_options = "-jar /data/runtimes/languagetool/languagetool-commandline.jar --languagemodel /data/runtimes/languagemodel/ --word2vecmodel /data/runtimes/word2vec/ --disable WHITESPACE_RULE,COMMA_PARENTHESIS_WHITESPACE"
let g:ale_disable_lsp = 1
map <F3> :ALEToggle<CR>


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
