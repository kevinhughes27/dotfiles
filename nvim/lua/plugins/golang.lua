return {
  {
    'crispgm/nvim-go',
    config = function()
      require('go').setup({
        -- lint_prompt_style: qf (quickfix), vt (virtual text)
        lint_prompt_style = 'vt',
        -- but the linter is kind of jank so just disable it. I have lsp still
        auto_lint = false,
      })
    end
  },
}
