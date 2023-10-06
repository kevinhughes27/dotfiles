local builtin = require('statuscol.builtin')

require('statuscol').setup({
  segments = {
    {
      sign = { name = { '.*' }, maxwidth = 1, colwidth = 1 },
    },
    {
      text = { builtin.lnumfunc }
    },
    {
      text = { ' ', builtin.foldfunc, ' ' },
      click = 'v:lua.ScFa',
      condition = { function()
        local cwd = vim.fn.getcwd()
        local notesdir = os.getenv('HOME') .. '/notes'
        local is_notes = string.find(cwd, notesdir)
        return is_notes
      end }
    },
  }
})
