local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {
  filters = {
    custom = {'.git', 'node_modules', '.cache', '__pycache__', '.DS_Store'},
  },
  renderer = {
    indent_markers = {
      enable = true
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
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
        {key = {'<CR>'},           cb = tree_cb('edit')},
        {key = {'<2-LeftMouse>'},  cb = tree_cb('edit')},
        {key = {'<2-RightMouse>'}, cb = tree_cb('cd')},
        {key = {'<C-t>'},          cb = tree_cb('tabnew')},
        {key = {'R'},              cb = tree_cb('refresh')},
        {key = {'a'},              cb = tree_cb('create')},
        {key = {'d'},              cb = tree_cb('remove')},
        {key = {'r'},              cb = tree_cb('rename')},
        {key = {'<C-r>'},          cb = tree_cb('full_rename')},
        {key = {'x'},              cb = tree_cb('cut')},
        {key = {'c'},              cb = tree_cb('copy')},
        {key = {'p'},              cb = tree_cb('paste')},
        {key = {'q'},              cb = tree_cb('close')},
      }
    }
  }
}
