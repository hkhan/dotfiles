" based on http://github.com/jferris/config_files/blob/master/vimrc

" This must be first, because it changes other options as a side effect.
set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage itself
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'ack.vim'
Bundle 'mudge/runspec.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'bdd/vim-scala'
Bundle 'JavaScript-Indent'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'kogent/vim-puppet'
Bundle 'matchit.zip'
Bundle 'nginx.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/ZoomWin'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" use the system clipboard
if has("clipboard")
  set clipboard=unnamed
endif

" disable code folding
set nofoldenable

" set encoding so unicode listchars can be used
set encoding=utf-8

" set the colour scheme
set t_Co=256

syntax enable
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1

set background=dark
colorscheme solarized

" Display extra whitespace
set list listchars=tab:»·,trail:·

" backups and swapfiles
set nobackup
set nowritebackup
set noswapfile
set history=50

" ui
set ruler
set showcmd
set incsearch
set nowrap
set splitbelow
set splitright
set hlsearch
" set window widths for fully maximizing windows
set wmw=0
set wmh=0
" case only matters with mixed case expressions
set ignorecase
set smartcase

" Always display the status line
set laststatus=2

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" move line commands
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd bufwritepost .vimrc call Pl#Load()

  " ruby related autocompletion
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" , is the leader character
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <silent> <leader>m :ZoomWin<CR>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
" map <Leader>m :Rmodel
" map <Leader>c :Rcontroller
" map <Leader>v :Rview
" map <Leader>u :Runittest
" map <Leader>f :Rfunctionaltest
" map <Leader>tm :RTmodel
" map <Leader>tc :RTcontroller
" map <Leader>tv :RTview
" map <Leader>tu :RTunittest
" map <Leader>tf :RTfunctionaltest
" map <Leader>sm :RSmodel
" map <Leader>sc :RScontroller
" map <Leader>sv :RSview
" map <Leader>su :RSunittest
" map <Leader>sf :RSfunctionaltest

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
" cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" " Maps autocomplete to tab
" imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

imap <S-CR>    <CR><CR>end<Esc>-cc


" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Color scheme
" colorscheme vividchalk
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu,preview
set wildmode=list:longest,list:full
set complete=.,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

let g:fuf_splitPathMatching=1

" Open URL
command! -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

set cursorline

" save file
map <Leader>s :w<cr>
map <Leader>q :q<cr>
" copy "
vmap <C-c> y
" Paste clipboard contents (ctrl-v)
imap <C-v> <esc>P
" cut selected text (ctrl-x)
vmap <C-x> x

map <C-right> <ESC>:tabnext<CR>
map <C-left> <ESC>:tabprevious<CR>

" strip trailing whitespace
" function! StripWhitespace()
"   exec ':%s/ \+$//gc'
" endfunction
" map <leader>sw :call StripWhitespace()<CR>
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" disable auto complete popup at the start
let g:acp_enableAtStartup=0

let g:stop_autocomplete=0

" function! CleverTab(type)
"     if a:type=='omni'
"         if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"             let g:stop_autocomplete=1
"             return "\<TAB>"
"         elseif !pumvisible() && !&omnifunc
"             return "\<C-X>\<C-O>\<C-P>"
"         endif
"     elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
"         return "\<C-X>\<C-N>\<C-P>"
"     elseif a:type=='next'
"         if g:stop_autocomplete
"             let g:stop_autocomplete=0
"         endif
"     endif
"     return ''
" endfunction

" inoremap <silent><C-Space> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>

function! InsertTabWrapper()
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

inoremap <expr> <C-j> ((pumvisible())?("\<Down>"):("<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<Up>"):("<C-k>"))

let g:ctrlp_clear_cache_on_exit = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
