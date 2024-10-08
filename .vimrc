"---------------------------
"--        .vimrc         --
"--      by lgaggini      --
"--      CC BY-SA 3.0     --
"---------------------------

"
" Plugins by plug
"
call plug#begin('~/.vim/plugs')
" general utilities
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'jamessan/vim-gnupg'
" completion
Plug 'ycm-core/YouCompleteMe'
" linting and tagging
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
" filetype specific plugin
Plug 'pearofducks/ansible-vim'
Plug 'rodjek/vim-puppet'
call plug#end()


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
"color muon                     " load a colorscheme
hi SpellCap ctermbg=6           " fix SpellCap color
set number                      " line numbers
hi LineNr ctermfg=White         " line numbers style
set linespace=0                 " no extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set foldlevel=99                " folding level
set foldmethod=indent           " folding method
set spelllang=it,en
autocmd FileType mail setlocal spell        " set spell for email

" Changing cursor shape
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" 5 -> blinking pipe
" 6 -> solid pipe
if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
else
    let &t_SI .= "\<Esc>[6 q"
    let &t_SR .= "\<Esc>[4 q"
    let &t_EI .= "\<Esc>[2 q"
    autocmd VimLeave * silent !echo -ne "\033[2 q"
endif

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
set guioptions=aAeimgr                  " custom gvim view
if has('gui_running')
color retrobox                          " custom gvim colorscheme
set guifont=Hack\ Nerd\ Font\ Mono\ 14  " custom gvim font
endif
if !has('gui_running')
set t_Co=256                            " powerline colors in terminal
endif

"
" Custom keys and shortcuts
"
let mapleader = "\<Space>"      " custom map leader
let g:mapleader = "\<Space>"    " custom map leader
map <Bar> <C-W>v<C-W><Right>    " vertical split
map <Bslash> <C-W>s<C-W><Down>  " horizontal split
map <Tab> <C-W>w                " cycle split by tab
map B :enew<CR>                 " new buffer
map gb :bnext<CR>               " cycle buffers by gb
map gB :bprev<CR>               " cycle buffers by gB
map <Leader>x :bd<CR>           " close buffer
map T :tabnew<CR>               " new tab
map gt :tabnext<CR>             " cycle tab by gt
map gT :tabprev<CR>             " cycle tab by gT
map X :tabclose<CR>             " close tab
map <Leader>ii mzgg=G`z         " reindent current file
" disable arrow to force vim keybindings
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
" replace arrow in command line mode too
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>

"
" Auto set filetype
"
autocmd BufRead,BufNewFile *.strace set filetype=strace   " strace file

"
" Plugins
"

" nerdtree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>          " tree toggle key
map <leader>e :NERDTreeFind<CR>                           " find files in tree
let NERDTreeShowBookmarks = 0                             " not show bookmark tree
let NERDTreeIgnore = []                                   " file to ignore
let NERDTreeChDirMode = 0                                 " not change vim working directory
let NERDTreeQuitOnOpen = 1                                " close tree after file open
let NERDTreeShowHidden = 1                                " show hidden files

" tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>            " tagbar toggle key
let g:tagbar_left = 0                                     " tagbar to the right
let g:tagbar_autofocus = 1                                " tagbar focus on open  
let g:tagbar_compact = 1                                  " compact view
let g:tagbar_singleclick = 1                              " go to tag with single click

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

" vim expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
