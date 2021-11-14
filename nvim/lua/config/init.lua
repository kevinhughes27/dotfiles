require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  }
})

require('config/icons')
require('config/lualine')

require('config/fzf')
require('config/nvim-tree')

require('config/lsp')
require('config/nvim-cmp')
require('config/formatter')
