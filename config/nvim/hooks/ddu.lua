-- lua_add {{{
local opt = { noremap = false }
require("user.utils").keymaps_set({
  -- ddu start prefixes
  { mode = "n", lhs = [[ d]], rhs = [[<Plug>(ddu-ff)]],    opts = opt },
  { mode = "n", lhs = [[ f]], rhs = [[<Plug>(ddu-filer)]], opts = opt },

  -- ddu-ui-ff starter
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)a]],
    rhs = function()
      vim.fn["ddu#start"]({
        name = "current-ff",
        sourceOptions = {
          file_rec = {
            path = vim.fn["vimrc#search_repo_root"](),
          },
        },
      })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)d]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "dotfiles-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)h]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "help-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)b]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "buffer-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)P]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "plugin-list-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)p]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "project-list-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)~]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "home-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)r]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "register-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)s]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "search-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)m]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "mrr-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)n]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "mru-ff" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-ff)C]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "highlight-ff" })
    end,
    opts = opt,
  },

  -- ddu-ui-filer starter
  {
    mode = "n",
    lhs = [[<Plug>(ddu-filer)a]],
    rhs = function()
      vim.fn["ddu#start"]({
        name = "project_root-filer",
        sourceOptions = {
          file = {
            path = vim.fn["vimrc#search_repo_root"](),
          },
        },
      })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-filer)f]],
    rhs = function()
      vim.fn["ddu#start"]({
        name = "current-filer",
        sourceOptions = {
          file = {
            path = vim.fn.expand("%:p:h"),
          },
        },
      })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-filer)d]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "dotfiles-filer" })
    end,
    opts = opt,
  },
  {
    mode = "n",
    lhs = [[<Plug>(ddu-filer)~]],
    rhs = function()
      vim.fn["ddu#start"]({ name = "home-filer" })
    end,
    opts = opt,
  },
})
-- }}}

-- lua_source {{{
-- Global option and param
vim.fn["ddu#custom#patch_global"]({
  uiOptions = {
    filer = {
      toggle = true,
    },
  },
  uiParams = {
    ff = {
      split = [[floating]],
      floatingBorder = [[single]],
      prompt = [[]],
      filterSplitDirection = [[floating]],
      filterFloatingPosition = [[top]],
      displaySourceName = [[long]],
      previewFloating = true,
      previewFloatingBorder = [[double]],
      previewSplit = [[horizontal]],
    },
    filer = {
      split = [[vertical]],
      splitDirection = [[topleft]],
      winWidth = vim.opt.columns:get() / 6,
      previewFloating = true,
      previewFloatingBorder = [[double]],
      previewCol = vim.opt.columns:get() / 4,
      previewRow = vim.opt.lines:get() / 2,
      previewWidth = vim.opt.columns:get() / 2,
      previewHeight = 20,
    },
  },
  sourceOptions = {
    _ = {
      ignoreCase = true,
      matchers = { "matcher_substring" },
    },
    file = {
      columns = { "icon_filename" },
    },
    dein = {
      defaultAction = [[cd]],
    },
    help = {
      defaultAction = [[open]],
    },
  },
  sourceParams = {
    dein_update = {
      useGraphQL = true,
    },
    marks = {
      jumps = true,
    },
    rg = {
      args = {
        [[--json]],
        [[--ignore-case]],
        [[--column]],
        [[--no-heading]],
        [[--color]],
        [[never]],
      },
      highlights = {
        word = [[Title]],
      },
    },
  },
  kindOptions = {
    file = {
      defaultAction = [[open]],
    },
    action = {
      defaultAction = [[do]],
    },
    word = {
      defaultAction = [[append]],
    },
    deol = {
      defaultAction = [[switch]],
    },
    readme_viewer = {
      defaultAction = [[open]],
    },
  },
  actionOptions = {
    narrow = { quit = false },
    echo = { quit = false },
    echoDiff = { quit = false },
  },
  columnParams = {
    icon_filename = {
      span = 2,
      iconWidth = 2,
      defaultIcon = {
        icon = [[]],
      },
    },
  },
})

-- UI:ff presets
-- call ddu#custom#patch_local('current-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [#{name: 'file_rec'}],
--   \ })
--
-- call ddu#custom#patch_local('dotfiles-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--     \ startFilter: v:true,
--     \ },
--   \ },
--   \ sourceOptions: #{
--     \ file_rec: #{path: expand('~/dotfiles')},
--     \ },
--   \ sources: [#{name: 'file_rec'}],
--   \ })
--
-- call ddu#custom#patch_local('project-list-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--     \ startFilter: v:true,
--     \ },
--   \ },
--   \ sourceOptions: #{
--     \ file: #{path: expand('$WORKING_DIR')},
--     \ },
--   \ sources: [#{name: 'file'}],
--   \ })
--
-- call ddu#custom#patch_local('help-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [
--     \ #{name: 'help'},
--     \ #{name: 'readme_viewer'},
--     \ ],
--   \ })
--
-- call ddu#custom#patch_local('search-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ autoAction: #{
--         \ delay: 0,
--         \ name: 'preview',
--         \ },
--       \ winRow: &lines / 4 - 10,
--       \ previewRow: &lines - 4,
--       \ previewHeight: 24,
--       \ ignoreEmpty: v:false,
--       \ autoResize: v:false,
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [#{
--     \ name: 'rg',
--     \ options: #{
--       \ matchers: [],
--       \ volatile: v:true,
--       \ },
--     \ }],
--   \ })
--
-- call ddu#custom#patch_local('buffer-ff', #{
--   \ ui: 'ff',
--   \ sources: [#{name: 'buffer'}],
--   \ })
--
-- call ddu#custom#patch_local('plugin-list-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--     \ startFilter: v:true,
--     \ }
--   \ },
--   \ sources: [#{name: 'dein'}],
--   \ })
--
-- call ddu#custom#patch_local('home-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--     \ startFilter: v:true,
--     \ },
--   \ },
--   \ sourceOptions: #{
--     \ file: #{path: expand('~')},
--     \ },
--   \ sources: [#{name: 'file'}],
--   \ })
--
-- call ddu#custom#patch_local('register-ff', #{
--   \ ui: 'ff',
--   \ sources: [#{name: 'register'}],
--   \ })
--
-- call ddu#custom#patch_local('mrr-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [#{
--     \ name: 'mr',
--     \ params: #{
--       \ kind: 'mrr',
--       \ current: v:false,
--       \ },
--     \ }],
--   \ })
--
-- call ddu#custom#patch_local('mru-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [#{
--     \ name: 'mr',
--     \ params: #{
--       \ kind: 'mru',
--       \ current: v:true,
--       \ },
--     \ }],
--   \ })
--
-- call ddu#custom#patch_local('highlight-ff', #{
--   \ ui: 'ff',
--   \ uiParams: #{
--     \ ff: #{
--       \ startFilter: v:true,
--       \ },
--     \ },
--   \ sources: [#{name: 'highlight'}],
--   \ })
--
--
-- -- UI:filer presets
-- call ddu#custom#patch_local('current-filer', #{
--   \ ui: 'filer',
--   \ sources: [#{name: 'file'}],
--   \ })
--
-- call ddu#custom#patch_local('project_root-filer', #{
--   \ ui: 'filer',
--   \ sources: [#{name: 'file'}],
--   \ })
--
-- call ddu#custom#patch_local('dotfiles-filer', #{
--   \ ui: 'filer',
--   \ sources: [#{name: 'file'}],
--   \ sourceOptions: #{
--     \ file: #{
--       \ path: expand('~/dotfiles'),
--       \ },
--     \ },
--   \ })
--
-- call ddu#custom#patch_local('home-filer', #{
--   \ ui: 'filer',
--   \ sources: [#{name: 'file'}],
--   \ sourceOptions: #{
--     \ file: #{
--       \ path: expand('~'),
--       \ },
--     \ },
--   \ })

-- }}}
