require('render-markdown').setup({
  anti_conceal = {
    enabled = false
  },
  latex = {
    enabled = false
  },
  heading = {
    icons = {},
    border = true,
    left_pad = 1,
    backgrounds = { 'ColorColumn' },
  },
  checkbox = {
    unchecked = {
      highlight = 'Normal'
    },
    checked = {
      highlight = 'SpecialComment'
    },
  },
  code = {
    style = 'full',
    width = 'block',
    left_pad = 2,
    right_pad = 2,
  },
})
