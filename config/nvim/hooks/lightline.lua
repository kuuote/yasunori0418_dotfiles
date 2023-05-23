-- lua_source {{{
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.laststatus = 3

local active = {
  left = {
    { 'mode', 'paste', 'skk_mode' },
    { 'relativepath', 'modified' },
  },
  right = {
    { 'percent', 'lineinfo' },
    { 'fileformat', 'fileencoding', 'filetype' },
  },
}

local inactive = {
  left = {
    { 'filename' }
  },
  right = {
    { 'lineinfo' },
    { 'percent' },
  },
}

local tabline = {
  left = {
    { 'tabs' },
  },
  right = {
    { 'git_branch' },
  },
}

local tab = {
  active = { 'tabnum', 'filename', 'modified' },
  inactive = { 'tabnum', 'filename' },
}

local separator = {
  left = '',
  right = '',
}

local subseparator = {
  left = '',
  right = ' ',
}

local component_function  = {
  git_branch = [[vimrc#lightline_git_branch]],
  mode = [[vimrc#lightline_custom_mode]],
  skk_mode = [[lightline_skk#mode]],
}

vim.g.lightline = {
  colorscheme = 'nordfox',
  active = active,
  inactive = inactive,
  tabline = tabline,
  tab = tab,
  separator = separator,
  subseparator = subseparator,
  component_function = component_function,
}

-- command! -bar LightlineUpdate call lightline#init()| call lightline#colorscheme()| call lightline#update()

-- }}}
