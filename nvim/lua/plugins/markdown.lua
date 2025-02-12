return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
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
          position = 'overlay',
          checked = {
            scope_highlight = '@markup.strikethrough'
          },
        },
        code = {
          style = 'full',
          width = 'block',
          left_pad = 2,
          right_pad = 2,
        },
      })

      vim.api.nvim_set_hl(0, '@markup.strikethrough', {fg='#546178', strikethrough=true})
    end,
  },
}
