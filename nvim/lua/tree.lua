local g = vim.g

g.nvim_tree_ignore = {".git", "node_modules", ".cache", ".DS_Store"}
g.nvim_tree_width = 30
g.nvim_tree_auto_resize = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
  git = 0
}

-- Remove all default bindings.
g.nvim_tree_disable_default_keybindings = 1

-- Add back most of the default bindings
-- but not `-` which I use to resize splits
local tree_cb = require("nvim-tree.config").nvim_tree_callback

g.nvim_tree_bindings = {
  {key = {"<CR>"},           cb = tree_cb("edit")},
  {key = {"<2-LeftMouse>"},  cb = tree_cb("edit")},
  {key = {"<2-RightMouse>"}, cb = tree_cb("cd")},
  {key = {"<C-t>"},          cb = tree_cb("tabnew")}, -- this is now opening the window picker which I don't want. How can I new tab open now?
  {key = {"R"},              cb = tree_cb("refresh")},
  {key = {"a"},              cb = tree_cb("create")},
  {key = {"d"},              cb = tree_cb("remove")},
  {key = {"r"},              cb = tree_cb("rename")},
  {key = {"<C-r>"},          cb = tree_cb("full_rename")},
  {key = {"x"},              cb = tree_cb("cut")},
  {key = {"c"},              cb = tree_cb("copy")},
  {key = {"p"},              cb = tree_cb("paste")},
  {key = {"q"},              cb = tree_cb("close")},
}

-- sync the tree but only on open
vim.api.nvim_exec(
[[
function! IsTreeOpen()
  return bufwinnr('NvimTree') != -1
endfunction

function! ToggleTree()
  if IsTreeOpen()
    NvimTreeClose
  else
    NvimTreeClose
    NvimTreeFindFile
  endif
endfunction
]],
true)
