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
nnoremap <Leader>a cc

" Directories and backups
set nobackup
set directory=~/.vim/tmp//
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

" Mapping for redraw
nnoremap <silent> <Leader>r :redraw!<Cr>

" Quickly switch and move tabs
" TODO: Make these commands accept ranges
nnoremap <silent> <C-h> :tabprev<Cr>
nnoremap <silent> <C-l> :tabnext<Cr>
nnoremap <silent> <Leader>th :execute 'tabmove ' . string(float2nr(fmod(
    \tabpagenr() - 2 + tabpagenr('$'), tabpagenr('$'))))<Cr>
nnoremap <silent> <Leader>tl :execute 'tabmove ' . string(float2nr(fmod(
    \tabpagenr(), tabpagenr('$'))))<Cr>
" "Insert mode is for inserting text"
"inoremap <C-h> <C-o>:tabprev<Cr>
"inoremap <C-l> <C-o>:tabnext<Cr>

" Highlight tabs and trailing whitespace
set listchars=tab:>.,trail:*
set list
" Nasty red background (also handles Windows ^M line endings)
highlight SpecialKey ctermfg=black ctermbg=red cterm=none term=none
nnoremap <silent> <Leader>l :highlight SpecialKey ctermfg=black    ctermbg=none
    \ cterm=none term=none<Cr>
nnoremap <silent> <Leader>L :highlight SpecialKey ctermfg=darkgray ctermbg=none
    \ cterm=bold term=bold<Cr>

" Improve matching-brace highlight colors
highlight MatchParen ctermfg=yellow ctermbg=none cterm=bold term=bold

" Commands for fixing up whitespace
" note - we set gdefault later
silent! command! -range FixTabs   :<line1>,<line2>s/\t/  /
silent! command! -range FixSpaces :<line1>,<line2>s/\s\+$//
nnoremap <silent> <Leader>wt :%FixTabs<Cr>
nnoremap <silent> <Leader>ws :%FixSpaces<Cr>
nnoremap <silent> <Leader>wa :%FixTabs<Cr>:%FixSpaces<Cr>
vnoremap <silent> <Leader>wt :FixTabs<Cr>
vnoremap <silent> <Leader>ws :FixSpaces<Cr>
vnoremap <silent> <Leader>wa :FixTabs<Cr>:FixSpaces<Cr>

" Fix control statements in code:
" "if(x)"  -> "if (x)"
" "for(x)" -> "for (x)"
" etc.
silent! command! -range FixControlStatements :
    \<line1>,<line2>s/\<\(if\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(elsif\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(elseif\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(for\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(foreach\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(while\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(try\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(catch\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(my\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(unless\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(until\)(/\1 (/e<bar>
    \<line1>,<line2>s/\<\(switch\)(/\1 (/e<bar>
nnoremap <silent> <Leader>wc :%FixControlStatements<Cr>
vnoremap <silent> <Leader>wc :FixControlStatements<Cr>

" Ensure spaces in code between braces and keywords
silent! command! -range FixBraces :
    \<line1>,<line2>s/){\s*$/) {/e<bar>
    \<line1>,<line2>s/\<\(else\){/\1 {/e<bar>
    \<line1>,<line2>s/\<\(try\){/\1 {/e<bar>
    \<line1>,<line2>s/\<\(catch\){/\1 {/e<bar>
    \<line1>,<line2>s/\<\(finally\){/\1 {/e<bar>
    \<line1>,<line2>s/\<\(do\){/\1 {/e<bar>
    \<line1>,<line2>s/}\(else\)\>/} \1/e<bar>
    \<line1>,<line2>s/}\(try\)\>/} \1/e<bar>
    \<line1>,<line2>s/}\(catch\)\>/} \1/e<bar>
    \<line1>,<line2>s/}\(finally\)\>/} \1/e<bar>
    \<line1>,<line2>s/}\(do\)\>/} \1/e<bar>
nnoremap <silent> <Leader>wb :%FixBraces<Cr>
vnoremap <silent> <Leader>wb :FixBraces<Cr>

" Enable line numbering
set number
set cpoptions+=n
highlight LineNr ctermfg=darkgray ctermbg=none cterm=bold term=bold
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

" Code completion
set completeopt=menu,menuone,preview

" Commands for dealing with vimrc
nnoremap <silent> <Leader>c :tabe ~/.vim/vimrc<Cr>
nnoremap <silent> <Leader>s :source ~/.vim/vimrc<Cr>

" Buffer settings
set hidden
set autoread

" Status bar and window title
set ruler
nnoremap <Leader>% :echo expand("%:p:n")<Cr>
set title

" Improve bracket matching
runtime macros/matchit.vim


""""" "Filetype-specific stuff"


" Set filetype for Django templates
autocmd BufNewFile,BufRead */templates/*.html set filetype=htmldjango
    \ commentstring={#%s#}

" Disable automatic Python folding
let g:pymode_folding = 0

" Set up haskellmode
let g:haddock_browser = "/usr/bin/firefox"
au BufEnter *.hs compiler ghc

" Change default Sparkup "next" mapping to C-f
" By default, it overwrites C-n (bad)
let g:sparkupNextMapping = '<c-f>'


""""" "Include bundled plugins via Pathogen"
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'python-mode')
call pathogen#infect()


""""" "Remaining settings from vimrc_example.vim"

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
