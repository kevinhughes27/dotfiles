return {
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux'
    },
    init = function()
      vim.g['test#strategy'] = 'vimux'       -- make test commands execute using vimux
      vim.g['test#python#runner'] = 'pytest' -- have to configure which python runner to use https://github.com/vim-test/vim-test#python
      vim.g['test#javascript#runner'] = 'vitest'
      vim.g['VimuxUseNearest'] = 1
      vim.g['VimuxHeight'] = '25'
    end,
    lazy = true,
    keys = {
      { '<C-t>', ':w<CR> :TestFile<CR>' },
      { '<C-l>', ':w<CR> :TestNearest<CR>' },
    },
  },
}
