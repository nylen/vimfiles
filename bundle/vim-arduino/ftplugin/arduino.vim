" Language:    Arduino
" Maintainer:  Chris Blazek <chris.blazek@gmail.com>
" URL:         http://github.com/kingbin/vim-arduino
" License:     GPL V3

if exists("b:vim_arduino")
  finish
endif

let b:vim_arduino = 1

set autowrite
set switchbuf=usetab

nnoremap <Leader>ac :!clear && make<CR>
nnoremap <Leader>au :!clear && make upload<CR>
nnoremap <Leader>as :!clear && make monitor<CR>

nnoremap <Leader>a0 :!clear && make upload PORT=/dev/ttyACM0<CR>
nnoremap <Leader>a1 :!clear && make upload PORT=/dev/ttyACM1<CR>
nnoremap <Leader>a2 :!clear && make upload PORT=/dev/ttyACM2<CR>

setlocal errorformat^=\%-G../libraries\%.\%#,\%-G../../libraries\%.\%#,%-G/Applications/Development/Arduino.app/Contents/Resources/Java\%.\%#


" Very simple
function! s:ArduinoMakeFile()

  :tabe Makefile
  :r ~/.vim/bundle/vim-arduino/templates/Makefile
  :w!

endfunction


command! -bang -bar ArduinoMakeFile call s:ArduinoMakeFile()
command! -bang -bar -nargs=* ArduinoMake :!make <args>
