local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    height = 0.9,
    width = 0.9,
    preview = {
      default = 'bat',
      scrollbar = false
    },
  },
  actions = {
    files = {
      ["default"] = fzf.actions.file_edit_or_qf,
      ["ctrl-s"]  = fzf.actions.file_split,
      ["ctrl-x"]  = fzf.actions.file_vsplit,
      ["ctrl-t"]  = fzf.actions.file_tabedit,
    }
  }
})

vim.api.nvim_create_user_command('Rg', fzf.live_grep, {nargs = 0, desc = 'FzfLua live_grep'})
