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

