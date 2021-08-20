set pumblend=30

nnoremap [denite] <Nop>
nmap <Space>d [denite]
nnoremap [denite]b :Denite buffer file:new<CR>
nnoremap [denite]f :Denite file file:new<CR>
nnoremap [denite]a :Denite file buffer file:new<CR>
nnoremap [denite]r :Denite file/rec buffer file:new<CR>

augroup denite
    autocmd!
    autocmd FileType denite set winblend=30
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')

        " Preview using bat.
        nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview_bat')
        
        " Command to close Denite buffer, ESC and q
        nnoremap <silent><buffer><expr> <ESC>
        \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')

        nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
    endfunction
augroup end

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
    \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
" Ripgrep command on grep source
call denite#custom#var('grep', {
    \ 'command': ['rg'],
    \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
    \ 'recursive_opts': [],
    \ 'pattern_opt': ['--regexp'],
    \ 'separator': ['--'],
    \ 'final_opts': [],
    \ })
call denite#custom#option('_', {
    \ 'split': 'floating'
    \ })
