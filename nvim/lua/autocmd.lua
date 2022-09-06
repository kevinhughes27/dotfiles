-- Auto Commands

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
      vim.fn.execute('OSCYankReg +')

      -- highlight copied text
      vim.highlight.on_yank({ higroup='YankPost', timeout=500 })
    end
  }
)
