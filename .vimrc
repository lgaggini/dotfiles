"---------------------------
"--        .vimrc         --
"--      by lgaggini      --
"--      CC BY-SA 3.0     --
"---------------------------

"
" Plugins by vundle
"
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'zhaocai/GoldenView.Vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'itchyny/lightline.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jamessan/vim-gnupg'
Bundle 'terryma/vim-expand-region'

"
" General
"
set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8              " utf8 encoding
set history=1000                " increase history (default is 20)
filetype plugin indent on       " load file type plugins + indentation
set hidden                      " allow buffer switching without saving
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set backup                      " file backup
set backupdir=~/.vim/backup     " directory for backup files
set directory=~/.vim/swap       " directory for swap files
set clipboard=unnamed           " map default copy/paste register to * (clipboard)

"
" Editor view
"
syntax on                       " syntax highlighting
set background=dark             " dark background
color desert                    " load a colorscheme
set number                      " line numbers
hi LineNr ctermfg=White         " line numbers style
set linespace=0                 " no extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set foldlevel=99                " folding level
set foldmethod=indent           " folding method
set cursorline                  " highlight current line
if &term =~ "xterm\\|rxvt"      " change cursor color on mode  
  :silent !echo -ne "\033]12;darkcyan\007"
  let &t_SI = "\033]12;lightgreen\007"
  let &t_EI = "\033]12;darkcyan\007"
  autocmd VimLeave * :!echo -ne "\033]12;grey\007"
endif
set spelllang=it,en
autocmd FileType mail setlocal spell        " set spell for email

"
" UI
" 
set laststatus=2                " set a status line
set selectmode+=mouse           " add mouse for select
set mouse=a                     " enable mouse usage
set showmode                    " display the current mode
set showcmd                     " display incomplete commands
set winminheight=0              " windows can be 0 line high 
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set gdefault                    " the /g flag on :s substitutions by default
set list                        " show invisible charachter
set autoread                    " automatically reloads file if changed outside
set splitbelow                  " split new window below current window
set nojoinspaces                " use just one space to join string

"
" Searching
"
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"
" Formatting
"
set nowrap                      " don't wrap lines
set autoindent                  " indent
set smarttab                    " make <tab> and <backspace> smarter
set shiftwidth=4                " a tab is two spaces
set tabstop=4                   " indentation of two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"
" GUI
"
set guioptions=aAeimgr                              " custom gvim view
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11  " custom gvim font
if has('gui_running')
    color muon                      " custom gvim colorscheme
endif
if !has('gui_running')
  set t_Co=256                      " powerline colors in terminal
endif

"
" Custom keys and shortcuts
"
let mapleader = "\<Space>"      " custom map leader
let g:mapleader = "\<Space>"    " custom map leader
map <Leader>c :bp<bar>bd#<CR>   " close buffer without lose split
map <Leader>o :on<CR>           " cancel split

"
" Plugins
"

" nerdtree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>          " tree toggle key
map <leader>e :NERDTreeFind<CR>                           " find files in tree
" autocmd vimenter * if !argc() | NERDTree | endif          " open tree on startup without file
let NERDTreeShowBookmarks = 0                             " not show bookmark tree
let NERDTreeIgnore = []                                   " file to ignore
let NERDTreeChDirMode = 0                                 " not change vim working directory
let NERDTreeQuitOnOpen = 1                                " close tree after file open
let NERDTreeShowHidden = 1                                " show hidden files

" minibufferexplorer
let g:miniBufExplUseSingleClick = 1                       " single click for open buffer
let g:miniBufExplSplitBelow = 0                           " minibuffer bar on top
let g:miniBufExplModSelTarget = 1                         " compatibility with other explorers (tagbar)
map <C-j> :bnext<CR>                                      " map j-k to move between buffer
map <C-k> :bprev<CR>
map <C-Left> :bprev<CR>                                   " map left-right to move between buffer
map <C-Right> :bnext<CR>
map <C-Tab> :bnext<CR>                                    " map Tab to cycle between bufffer

" tagbar
nmap <F9> :TagbarToggle<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>            " tagbar toggle key
let g:tagbar_left = 0                                     " tagbar to the right
let g:tagbar_autofocus = 1                                " tagbar focus on open  
let g:tagbar_compact = 1                                  " compact view
let g:tagbar_singleclick = 1                              " go to tag with single click

" neocomplete
let g:neocomplete#enable_at_startup = 1                 " enable at startup
let g:neocomplete#enable_camel_case_completion = 1      " use camel case completion
let g:neocomplete#enable_smart_case = 1                 " use smartcase
let g:neocomplete#enable_underbar_completion = 1        " use underbar completion
let g:neocomplete#min_syntax_length = 3                 " minimum syntax keyword length
let g:neocomplete#enable_auto_delimiter = 1             " auto insertion of delimiter
let g:neocomplete#enable_auto_select = 0                " auto selection of first candidate
if !exists('g:neocomplete_keyword_patterns')            " define keyword
  let g:neocomplete#keyword_patterns = {}               " define keyword
endif                                                     " define keyword
let g:neocomplete#keyword_patterns['default'] = '\h\w*' " define keyword
inoremap <expr><CR>    neocomplete#smart_close_popup() . "\<CR>" " close popup and save indent
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"          " completion. 
inoremap <expr><C-h>   neocomplete#smart_close_popup()."\<C-h>"  " close popup and delete backword char
inoremap <expr><BS>    neocomplete#smart_close_popup()."\<C-h>"  " close popup and delete backword char 
inoremap <expr><C-y>   neocomplete#close_popup()                 " close popup
inoremap <expr><C-e>   neocomplete#cancel_popup()                " close popup
inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"     " cursor moving in insert mode
inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"    " cursor moving in insert mode
inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"       " cursor moving in insert mode
inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"     " cursor moving in insert mode
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS " enable omni completion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete           " enable omni completion
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags             " enable omni completion

" powerline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" syntastic
let g:syntastic_python_checkers=['pep8']

" goldenview

" nerdcommenter

" vim expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
