function! vimrc#lightline_git_branch() abort
  if gitbranch#name() ==# ''
    return ''
  else
    if &ambiwidth =~# 'single'
      return ' ' . gitbranch#name()
    else
      return '' . gitbranch#name()
    endif
  endif
endfunction

function! vimrc#lightline_custom_mode() abort
  if lightline#mode() ==# 'INSERT' || lightline#mode() ==# 'COMMAND' || lightline#mode() ==# 'REPLACE'
    if get(g:, 'loaded_skkeleton') == 0
      return lightline#mode()
    endif

    if skkeleton#mode() !=# ''
      return lightline#mode() . '-SKK'
    endif

  endif

  return lightline#mode()
endfunction

function! vimrc#molder_change_cwd() abort
  if &filetype ==# 'molder'
    let molder_cwd = substitute(bufname('%'), expand('~'), '~', '')
    let molder_cwd = substitute(molder_cwd, '/$', '', '')
    call chdir(molder_cwd)
    echomsg 'Change current working directory to [' . molder_cwd . ']'
  endif
endfunction
