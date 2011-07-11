" Based on Bram's example vimrc file ( vimrc_example.vim )

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set <Leader> to comma
" This works because I can't think of a time when I needed to type a comma
" that was not followed by a space.
let mapleader=","

" Tabs/indentation
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
" Enter insert mode on the current line at the current indentation level
nnoremap <Leader>a ddO

" Directories and backups
set nobackup
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set undofile

" Use Tab instead of Esc in most places
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
" Make ,, insert a tab
inoremap <Leader>, <Tab>
" Make ,<Tab> insert a comma and leave insert mode
inoremap <Leader><Tab> ,<Esc>`^

" Switch a couple of mappings
noremap 0 ^
noremap ^ 0
noremap ' `
noremap ` '

" Scrolling-related things
noremap <C-e> 5<C-e>
noremap <C-y> 5<C-y>
noremap <C-j> 5j5<C-e>
noremap <C-k> 5k5<C-y>
set scrolloff=5

" Quickly switch and move tabs
nnoremap <C-h> :tabprev<Cr>
nnoremap <C-l> :tabnext<Cr>
nnoremap <Leader>th :execute 'tabmove ' . (tabpagenr() - 2)<Cr>
nnoremap <Leader>tl :execute 'tabmove ' . tabpagenr()<Cr>
" "Insert mode is for inserting text"
"inoremap <C-h> <C-o>:tabprev<Cr>
"inoremap <C-l> <C-o>:tabnext<Cr>

" Highlight tabs and trailing whitespace
set listchars=tab:>-,trail:*
set list
" Nasty red background (also handles Windows ^M line endings)
highlight SpecialKey ctermfg=black ctermbg=red

" Improve matching-brace highlight colors
highlight MatchParen ctermfg=yellow ctermbg=none cterm=bold

" Commands for fixing up whitespace
" note - we set gdefault later
cabbrev FixTabs s/\t/  /
cabbrev FixSpaces s/\s\+$//
nmap <Leader>wt :%FixTabs<Cr>
nmap <Leader>ws :%FixSpaces<Cr>
nmap <Leader>wa :%FixTabs<Cr>:%FixSpaces<Cr>
vmap <Leader>wt :FixTabs<Cr>
vmap <Leader>ws :FixSpaces<Cr>
vmap <Leader>wa :FixTabs<Cr>:FixSpaces<Cr>

" Enable line numbering
set number
set cpoptions+=n
highlight LineNr term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=NONE
set numberwidth=3

" Better search options
set incsearch
set nohlsearch
set gdefault

" Commands, tab completion, and history
set showcmd
set wildmenu
set wildmode=list:longest,full
set history=1000

" Commands for dealing with vimrc
nnoremap <Leader>c :tabe ~/.vim/vimrc<Cr>
nnoremap <Leader>s :source ~/.vim/vimrc<Cr>

" Buffer settings
set hidden
set autoread

" Status bar and window title
set ruler
nnoremap <Leader>% :echo expand("%:p:n")<Cr>
set title

" Improve bracket matching
runtime macros/matchit.vim


" Include bundled plugins via Pathogen
call pathogen#runtime_append_all_bundles()


""" Remaining settings from vimrc_example.vim

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
