require('render-markdown').setup({
  heading = {
    icons = {},
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
    style = 'normal',
    width = 'block',
    left_pad = 2,
    right_pad = 2,
  },
})
