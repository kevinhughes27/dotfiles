return {
  {
    'crispgm/nvim-go',
    config = function()
      require('go').setup({
        lint_prompt_style = 'vt'
      })
    end
  },
}
