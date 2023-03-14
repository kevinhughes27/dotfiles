-- Auto Commands
--
local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })

vim.api.nvim_create_autocmd(
    'VimResized',
    {
        group = wr_group,
        pattern = '*',
        command = 'wincmd =',
        desc = 'Automatically resize windows when the host window size changes.'
    }
)

local yp_group = vim.api.nvim_create_augroup('YankPost', { clear = true })
vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    group = yp_group,
    pattern = '*',
    callback = function()
      -- copy to system clipboard using osc52 escape code
      require('osc52').copy_register('+')

      -- highlight copied text
      vim.highlight.on_yank({ higroup='YankPost', timeout=500 })
    end
  }
)

-- automatically source when config is saved
local cf_group = vim.api.nvim_create_augroup('Config', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = cf_group,
  pattern = 'nvim/**/*.lua',
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    -- can't re-source init.lua or plugins.lua with lazy.nvim
    -- init.lua is not included by the pattern
    if not string.find(file, "plugins.lua") then
      vim.cmd("source " .. file)
    end
  end
})

-- automatically leave NvimTree before leaving a tab
-- this makes the tabline display a filename which is more useful
vim.api.nvim_create_autocmd('TabLeave', {
  callback = function()
    local current_buffer = vim.api.nvim_buf_get_name(0)

    if current_buffer:match('NvimTree_%d+') then
      vim.api.nvim_exec('winc l', true)
    end
  end
})
