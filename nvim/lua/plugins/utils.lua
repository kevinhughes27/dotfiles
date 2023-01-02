return {
  -- lua utils
  {'nvim-lua/plenary.nvim'},

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- remote copy
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup({ silent = true })
    end
  },

  -- github link copy :GH
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- highlight urls
  {'itchyny/vim-highlighturl'},

  -- autolist
  {
    'gaoDean/autolist.nvim',
    config = function()
      require('autolist').setup({})
    end,
  },

  -- seamless split/tmux navigation
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end
  },

  -- smart split resize
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require('smart-splits').setup({})
    end,
  },

  -- test running
  {
    'vim-test/vim-test',
    dependencies = { 'preservim/vimux' },
    config = function()
      vim.g['test#strategy'] = 'vimux'       -- make test commands execute using vimux
      vim.g['test#python#runner'] = 'pytest' -- have to configure which python runner to use https://github.com/vim-test/vim-test#python
      vim.g['VimuxUseNearest'] = 0           -- don't use an exisiting pane
      vim.g['VimuxHeight'] = '25'
    end
  },

  -- gcc and gc + motion to comment
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- remember cursor position
  {
    'farmergreg/vim-lastplace',
    config = function()
      vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help,NvimTree'
    end
  },

  -- sublime style multiple cursors. ctrl-n to start
  {
    'mg979/vim-visual-multi',
    config = function()
      -- disable visual-multi-mappings
      -- (it binds to ctrl up/down which I use for navigation)
      vim.g.VM_default_mappings = 0
    end
  }
}
