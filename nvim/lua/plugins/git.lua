return {
  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- github link copy :GitLink
  {
    'linrongbin16/gitlinker.nvim',
    config = function()
      require('gitlinker').setup({})
    end
  },
}
