local g = vim.g

g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_width = 30
g.nvim_tree_indent_markers = 1

-- Remove all default bindings.
require'nvim-tree.view'.View.bindings = {}

-- Add back most of the detaul bindings
-- but not `-` which I use to resize splits
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

g.nvim_tree_bindings = {
  ["<CR>"]           = tree_cb("edit"),
  ["<2-LeftMouse>"]  = tree_cb("edit"),
  ["<2-RightMouse>"] = tree_cb("cd"),
  ["<C-x>"]          = tree_cb("split"),
  ["<C-z>"]          = tree_cb("vsplit"),
  ["<C-t>"]          = tree_cb("tabnew"),
  ["R"]              = tree_cb("refresh"),
  ["a"]              = tree_cb("create"),
  ["d"]              = tree_cb("remove"),
  ["r"]              = tree_cb("rename"),
  ["<C-r>"]          = tree_cb("full_rename"),
  ["x"]              = tree_cb("cut"),
  ["c"]              = tree_cb("copy"),
  ["p"]              = tree_cb("paste"),
  ["q"]              = tree_cb("close"),
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
