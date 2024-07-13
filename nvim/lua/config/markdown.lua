require('render-markdown').setup({
  heading = {
    icons = {'# ', '## ', '### ', '#### ', '##### ', '###### '},
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
    style = 'normal'
  },
})
