-- Bootstrap
require 'bootstrap'

-- Settings
require 'settings'

-- Init Plugins
require('lazy').setup('plugins', {})

-- Load Commands
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require 'config/autocmds'
    require 'config/commands'
    require 'config/keymaps'
  end
})
