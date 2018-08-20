" Based on Bram's example vimrc file ( vimrc_example.vim )

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Switch syntax highlighting on, when the terminal has colors
" Do this before loading a color scheme or customizing colors.
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" Load expected colors
colorscheme default

" Set <Leader> to comma
" This works because I can't think of a time when I needed to type a comma
" that was not followed by a space.
let mapleader=","

" Disable mouse (more annoying than useful)
set mouse=

" Tabs/indentation
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

" Directories and backups
set nobackup
set directory=~/.vim/tmp//
if exists('+undofile')
    set undodir=~/.vim/tmp
    set undofile
endif

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

" Fold code based on indentation
set foldmethod=indent
set nofoldenable " all folds open by default; use zi to toggle

" Highlight folds more subtly
highlight Folded ctermfg=white ctermbg=darkgray cterm=bold term=bold

" Highlight tabs and trailing whitespace (and Windows ^M line endings)
set listchars=tab:\ \ ,trail:*
set list
highlight SpecialKey ctermfg=red ctermbg=none cterm=bold term=bold
" Add a mapping to cycle the SpecialKey highlight style
nnoremap <silent> <Leader>l :call g:Highlight_specialkey_cycle()<Cr>
let g:highlight_specialkey = 0
function! g:Highlight_specialkey_cycle()
    let g:highlight_specialkey = (g:highlight_specialkey + 1) % 2 " 4
    if g:highlight_specialkey == 0
        " Nasty red background
        highlight SpecialKey ctermfg=black    ctermbg=red  cterm=none term=none
    elseif g:highlight_specialkey == 1
        " Nasty red foreground (tabs don't show up because we use them for
        " indentation at a8c)
        highlight SpecialKey ctermfg=red ctermbg=none cterm=bold term=bold
    "elseif g:highlight_specialkey == 2
    "    " Black background
    "    highlight SpecialKey ctermfg=black    ctermbg=none cterm=bold term=bold
    "elseif g:highlight_specialkey == 3
    "    " Gray background
    "    highlight SpecialKey ctermfg=darkgray ctermbg=none cterm=none term=none
    endif
endfunction
call g:Highlight_specialkey_cycle()

" Add a mapping to toggle paste mode
function! g:TogglePasteMode()
    if &paste
        setlocal nopaste
		echom ':set nopaste " READY FOR EDITING'
    else
        setlocal paste
		echom ':set paste " NOT READY FOR EDITING'
    endif
endfunction
nnoremap <silent> <Leader>p :call g:TogglePasteMode()<Cr>

" Emphasize matching-brace highlight color
highlight MatchParen ctermfg=red ctermbg=green cterm=bold term=bold

" Commands for fixing up whitespace
" note - we set gdefault later
silent! command! -range FixTabs   :<line1>,<line2>s/\t/    /
silent! command! -range FixSpaces :<line1>,<line2>s/\s\+$//
nnoremap <silent> <Leader>wt :%FixTabs<Cr>
nnoremap <silent> <Leader>ws :%FixSpaces<Cr>
nnoremap <silent> <Leader>wa :%FixTabs<Cr>:%FixSpaces<Cr>
vnoremap <silent> <Leader>wt :FixTabs<Cr>
vnoremap <silent> <Leader>ws :FixSpaces<Cr>
vnoremap <silent> <Leader>wa :FixTabs<Cr>:FixSpaces<Cr>

" Commands for reformatting code
" Source these from a separate file since they break syntax highlighting
runtime misc/reformat.vim

" Easier macro execution
nnoremap <Leader>q @

" Enable line numbering
set number
set cpoptions+=n
highlight LineNr ctermfg=none ctermbg=none cterm=none term=none
set numberwidth=3

" Better search options
set incsearch
set nohlsearch
set gdefault
set ignorecase
set smartcase

" Commands, tab completion, and history
set showcmd
set wildmenu
set wildmode=list:longest
set history=1000

" Code completion
set completeopt=menu,menuone,preview
set complete-=i " Searching includes can be slow

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

""" "Alignment mappings"
" Multiple delimiter match
nnoremap <Leader>A: :Tabularize /:<Cr>
vnoremap <Leader>A: :Tabularize /:<Cr>
nnoremap <Leader>A; :Tabularize /:<Cr>
vnoremap <Leader>A; :Tabularize /:<Cr>
nnoremap <Leader>A= :Tabularize /=<Cr>
vnoremap <Leader>A= :Tabularize /=<Cr>
nnoremap <Leader>a, :Tabularize /,/l0l1<Cr>
vnoremap <Leader>a, :Tabularize /,/l0l1<Cr>
" Collapse comma-aligned values
nnoremap <Leader>ac :s/ *,/,/<Cr>
vnoremap <Leader>ac :s/ *,/,/<Cr>
" Single delimiter match (see http://stackoverflow.com/questions/11497593)
nnoremap <Leader>a: :Tabularize /^[^:]*\zs:<Cr>
vnoremap <Leader>a: :Tabularize /^[^:]*\zs:<Cr>
nnoremap <Leader>a; :Tabularize /^[^:]*\zs:<Cr>
vnoremap <Leader>a; :Tabularize /^[^:]*\zs:<Cr>
nnoremap <Leader>a= :Tabularize /^[^=]*\zs=<Cr>
vnoremap <Leader>a= :Tabularize /^[^=]*\zs=<Cr>
" Align PHP arrays at =>
nnoremap <Leader>a> :Tabularize /^[^=]*\zs=/l1c0l0<Cr>
vnoremap <Leader>a> :Tabularize /^[^=]*\zs=/l1c0l0<Cr>


""""" "Filetype-specific stuff"

" Set filetype for Django templates / Swig views
" augroup filetype htmldjango
"     autocmd!
"     autocmd BufNewFile,BufRead */templates/*.html set filetype=htmldjango
"         \ commentstring={#%s#}
"     autocmd BufNewFile,BufRead */views/*.html set filetype=htmldjango
"         \ commentstring={#%s#}
" augroup END

" Set filetype for MediaWiki markup files
augroup filetype mediawiki
    autocmd!
    autocmd BufRead,BufNewFile *.wiki set filetype=mediawiki
augroup END

" Set filetype for .json files
augroup filetype json
    autocmd!
    autocmd BufRead,BufNewFile *.json set filetype=javascript
augroup END

" Set filetype for .scad files
augroup filetype scad
    " TODO real syntax highlighting
    autocmd!
    autocmd BufRead,BufNewFile *.scad set filetype=javascript
augroup END

augroup NodeExports
    autocmd!
    autocmd User Node call s:mapExportsCommands()
augroup end

function! s:mapExportsCommands()
    nnoremap <silent> <Leader>ne :s/^function \(\w\+\)/exports.\1 = function/<Cr>$%:s/;\?$/;/<Cr>%0
    nnoremap <silent> <Leader>nf :s/^exports\.\(\w\+\) = function/function \1/<Cr>$%:s/;\?$//<Cr>%0
endfunction

" Prevent this error on `crontab -e`:
" crontab: temp file must be edited in place
" http://vim.wikia.com/wiki/Editing_crontab
augroup crontab_e
    autocmd!
    autocmd filetype crontab set backupcopy=yes
augroup end


""""" "Other autocmds"

" from http://stackoverflow.com/a/4294176/106302
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir = fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


""""" "Plugin settings"

" Disable automatic Python folding
let g:pymode_folding = 0

" Set up haskellmode
let g:haddock_browser = "/usr/bin/firefox"
augroup compiler ghc
    autocmd!
    autocmd BufEnter *.hs compiler ghc
augroup END

" Change default Sparkup "next" mapping to C-f
" By default, it overwrites C-n (bad)
let g:sparkupNextMapping = '<c-f>'

" DetectIndent settings
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
let g:detectindent_autodetect = 1
"let g:detectindent_verbosity = -1 " Show what indent options were chosen

" HTML indentation settings
let g:html_indent_inctags = 'html,body,head,tbody,li,p,template'

" Allow modelines in first 20 lines of files
let g:secure_modelines_modelines = 20


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
" if has('mouse')
"     set mouse=a
" endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx

        autocmd!

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
