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

-- manually sync to pbcopy if present tp sync my VM clipboard to the host
-- otherwise yank goes to the tmux clipboard and does not get synced.
-- should be possible to do this with OSC 52 but I couldn't get it working
-- https://github.com/tmux/tmux/wiki/Clipboard
-- prefix ] will paste the tmux clipboard which can confirm things are getting
-- into there
vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    group = yp_group,
    pattern = '*',
    callback = function()
      local event = vim.v.event
      vim.fn.system("echo " .. table.concat(event.regcontents, "\n") .. "  | pbcopy")
      vim.highlight.on_yank({ higroup='YankPost', timeout=500 })
    end
  }
)
