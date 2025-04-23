require 'bootstrap'
require 'settings'
require('lazy').setup({
  spec = {
    import = 'plugins'
  },
  rocks = {
    enabled = false
  }
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require 'autocmds'
    require 'commands'
    require 'keymaps'
  end
})
