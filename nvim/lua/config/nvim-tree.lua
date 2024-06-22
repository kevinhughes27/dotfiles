require('nvim-tree').setup {
  filters = {
    custom = {'.git\\>','node_modules', '\\.cache', '__pycache__', '.DS_Store'},
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
    preserve_window_proportions = true,
  },
  actions = {
    change_dir = {
      restrict_above_cwd = true,
    }
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', '<TAB>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<C-h>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'r', api.fs.rename_full, opts('Rename: Full Path'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  end,
}
