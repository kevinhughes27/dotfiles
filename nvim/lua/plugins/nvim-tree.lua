return {
  'kyazdani42/nvim-tree.lua',
  lazy = true,
  keys = {
    { '<C-b>', ':NvimTreeFindFileToggle<CR>', silent = true },
  },
  config = function()
    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    require('nvim-tree').setup {
      filters = {
        custom = {'.git\\>','node_modules', '.cache', '__pycache__', '.DS_Store'},
      },
      renderer = {
        indent_markers = {
          enable = true
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = false,
          },
        },
      },
      view = {
        side = 'left',
        width = 30,
        adaptive_size = true,
        preserve_window_proportions = true,
        mappings = {
          custom_only = true,
          list = {
            {key = {'<TAB>'},          cb = tree_cb('preview')}, -- opens the file but keeps cursor in tree
            {key = {'<CR>'},           cb = tree_cb('edit')},
            {key = {'<2-LeftMouse>'},  cb = tree_cb('edit')},
            {key = {'<C-t>'},          cb = tree_cb('tabnew')},
            {key = {'<C-s>'},          cb = tree_cb('split')},
            {key = {'<C-h>'},          cb = tree_cb('vsplit')},
            {key = {'R'},              cb = tree_cb('refresh')},
            {key = {'a'},              cb = tree_cb('create')},
            {key = {'d'},              cb = tree_cb('remove')},
            {key = {'r'},              cb = tree_cb('full_rename')},
            {key = {'x'},              cb = tree_cb('cut')},
            {key = {'c'},              cb = tree_cb('copy')},
            {key = {'p'},              cb = tree_cb('paste')},
            {key = {'q'},              cb = tree_cb('close')},
            {key = {'W'},              cb = tree_cb('collapse_all')},
          }
        }
      },
      actions = {
        change_dir = {
          restrict_above_cwd = true,
        }
      }
    }
  end
}
