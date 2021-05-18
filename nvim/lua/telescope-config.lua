local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    prompt_position = "top",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        preview_width = 0.6,
      },
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        -- doesn't work. maybe vim binds this to something already
        -- ["<C-z"] = actions.file_vsplit
      },
    },
  }
}
