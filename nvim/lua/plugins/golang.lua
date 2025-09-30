return {
  {
    'crispgm/nvim-go',
    config = function()
      require('go').setup({
        lint_prompt_style = 'vt',
        -- linter_flags = {
        --   revive = {'-config', '~/revive.toml'}
        -- },
      })
    end
  },
}
