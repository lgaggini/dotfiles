"---------------------------
"--        .vimrc         --
"--      by lgaggini      --
"--      CC BY-SA 3.0     --
"---------------------------

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
  :silent !echo -ne "\033]12;lightgreen\007" 
  let &t_SI = "\033]12;darkcyan\007" 
  let &t_EI = "\033]12;lightgreen\007" 
  autocmd VimLeave * :!echo -ne "\033]12;grey\007" 
endif
set spelllang=it,en
autocmd FileType mail setlocal spell " set spell for email 

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
set autoindent smartindent      " indent and smartindent
set smarttab                    " make <tab> and <backspace> smarter
set shiftwidth=4                " a tab is two spaces
set tabstop=4                   " indentation of two spaces  
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"
" GUI
"
set guioptions=aAeimgr            " custom gvim view
set guifont=DejaVu\ Sans\ Mono\ 10" custom gvim font
if has('gui_running')
    color muon                    " custom gvim colorscheme
endif

"
" Custom keys and shortcuts
"
let mapleader = ","             " custom map leader
let g:mapleader = ","           " custom map leader
map <Leader>c :bp<bar>bd#<CR>   " close buffer without lose split

"
" Plugins
"
" pathogen
call pathogen#infect()                                    " load pathogen bundle

" nerdtree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>          " tree toggle key
map <leader>e :NERDTreeFind<CR>                           " find files in tree
autocmd vimenter * if !argc() | NERDTree | endif          " open tree on startup without file
let NERDTreeShowBookmarks = 0                             " not show bookmark tree
let NERDTreeIgnore = []                                   " file to ignore
let NERDTreeChDirMode = 0                                 " not change vim working directory
let NERDTreeQuitOnOpen = 1                                " close tree after file open
let NERDTreeShowHidden = 1                                " show hidden files

" minibufferexplorer
let g:miniBufExplUseSingleClick = 1                       " single click for open buffer
let g:miniBufExplSplitBelow = 0                           " minibuffer bar on top
let g:miniBufExplModSelTarget = 1                         " compatibility with other explorers (tagbar)

" tagbar
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>            " tagbar toggle key
let g:tagbar_left = 0                                     " tagbar to the right
let g:tagbar_autofocus = 1                                " tagbar focus on open  
let g:tagbar_compact = 1                                  " compact view
let g:tagbar_singleclick = 1                              " go to tag with single click

" neocomplcache
let g:neocomplcache_enable_at_startup = 1                 " enable at startup
let g:neocomplcache_enable_camel_case_completion = 1      " use camel case completion
let g:neocomplcache_enable_smart_case = 1                 " use smartcase
let g:neocomplcache_enable_underbar_completion = 1        " use underbar completion
let g:neocomplcache_min_syntax_length = 3                 " minimum syntax keyword length
let g:neocomplcache_enable_auto_delimiter = 1             " auto insertion of delimiter
let g:neocomplcache_enable_auto_select = 0                " auto selection of first candidate
if !exists('g:neocomplcache_keyword_patterns')            " define keyword
  let g:neocomplcache_keyword_patterns = {}               " define keyword
endif                                                     " define keyword
let g:neocomplcache_keyword_patterns['default'] = '\h\w*' " define keyword
inoremap <expr><CR>    neocomplcache#smart_close_popup() . "\<CR>" " close popup and save indent
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"          " completion. 
inoremap <expr><C-h>   neocomplcache#smart_close_popup()."\<C-h>"  " close popup and delete backword char
inoremap <expr><BS>    neocomplcache#smart_close_popup()."\<C-h>"  " close popup and delete backword char 
inoremap <expr><C-y>   neocomplcache#close_popup()                 " close popup
inoremap <expr><C-e>   neocomplcache#cancel_popup()                " close popup
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"     " cursor moving in insert mode
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"    " cursor moving in insert mode
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"       " cursor moving in insert mode
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"     " cursor moving in insert mode

" powerline

" syntastic
let g:syntastic_python_checkers=['pep8']
