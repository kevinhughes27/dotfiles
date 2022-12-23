-- bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
  is_bootstrap = true
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

require 'plugins'

-- automatically sync after cloning packer.nvim
if is_bootstrap then
  require('packer').sync()
  vim.api.nvim_create_autocmd('User PackerComplete', { command = ':q' })
else
  require 'settings'
  require 'colors'
  require 'icons'
  require 'autocmd'
  require 'commands'
  require 'mappings'
end
