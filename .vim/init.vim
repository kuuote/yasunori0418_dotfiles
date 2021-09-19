" dein.vim setting.
source ~/dotfiles/.vim/rc/dein.vim

" Startup initial settings.
source ~/dotfiles/.vim/rc/option.vim

" Key bind settings.
source ~/dotfiles/.vim/rc/keybind.vim

" Neovide settings{{{

if exists('g:neovide')
    " Font and size settings when using GUI
    set guifont=Cica:h14

    " East asia ambigunous width ploblem.
    set ambiwidth=double

    " Refresh rate
    let g:neovide_refresh_rate=60

    " Cursor settings{{{
    
    " Animation length
    let g:neovide_cursor_animation_length=0.05

    " Animation trail length
    let g:neovide_cursor_trail_length=0.4

    " }}}

endif

" }}}
