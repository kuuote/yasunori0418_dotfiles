" Normal Mode:{{{
" Save file when the push Space+w.
nnoremap <Space>w :w<CR>


" US Keyboard layout mapping.
" Exchange Colon and Semi-Colon.
" nnoremap ; :
nnoremap : ;
nnoremap q; q:


" Do not save the things erased by x and s in the register.
nnoremap x "_x

" For vim-sandwich.
" nnoremap s <Nop>

" Opens the file name under the cursor.
nnoremap gf gF

" }}}


" Insert Mode:{{{

" Exit insert mode.
inoremap <silent> jj <ESC>

" }}}


" Visual Mode:{{{

" Exchange Colon and Semi-Colon.
" xnoremap ; :
xnoremap : ;


" Do not save the things erased by x and s in the register.
xnoremap x "_x
xnoremap s "_s

" }}}


" Command {{{

function! s:Clear_Register() abort
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
      call setreg(r, [])
    endfor
endfunction

command! Cleareg call s:Clear_Register()

" }}}
