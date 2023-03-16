-- Plugins
--
return {
  -- theme
  {
    'navarasu/onedark.nvim',
    priority=100,
    config = function() require('config/onedark') end,
  },

  -- icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function() require('config/icons') end,
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('config/lualine') end,
  },

  -- tabline
  {
    'rafcamlet/tabline-framework.nvim',
    config = function()
      require('config/tabline')
    end,
    lazy = true,
    event = 'TabNew',
    keys = {
      { '<C-z>', ':tab split<CR>', silent = true, desc = "zoom (opens new tab)" },
      { '<Tab>', ':tabnext<CR>', silent = true },
      { '<S-Tab>', ':tabprev<CR>', silent = true },
    }
  },

  -- file tree
  {
    'kyazdani42/nvim-tree.lua',
    lazy = true,
    keys = {
      { '<C-b>', ':NvimTreeFindFileToggle<CR>', silent = true },
    },
    cmd = 'NvimTreeOpen',
    config = function() require('config/nvim-tree') end,
  },

  -- fzf
  {
    'ibhagwan/fzf-lua',
    lazy = false,
    config = function()
      local actions = require('fzf-lua.actions')
      require('fzf-lua').setup({
        fzf_bin = 'fzf-tmux',
        fzf_opts = { ['--border'] = 'rounded' },
        fzf_tmux_opts = { ['-p'] = '90%,90%' },
        winopts = { preview = { default = 'bat', layout = 'horizontal' } },
        oldfiles = {
          cwd_only = true,
          stat_file = true, -- verify files exist on disk
          include_current_session = true, -- include bufs from current session
        },
        actions = {
          files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-s']  = actions.file_split,
            ['ctrl-h']  = actions.file_vsplit,
            ['ctrl-t']  = actions.file_tabedit,
          },
        },
      })
    end,
    keys = {
      { '<C-p>', ':FzfLua files<CR>' },
      { '<C-h>', ':FzfLua oldfiles<CR>' },
      { '<C-f>', ':FzfLua grep_cword<CR>' },
    }
  },

  -- seamless split/tmux navigation
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
    lazy = false,
    keys = {
      { '<C-Left>',  ':TmuxNavigateLeft<CR>',  silent = true },
      { '<C-Down>',  ':TmuxNavigateDown<CR>',  silent = true },
      { '<C-Up>',    ':TmuxNavigateUp<CR>',    silent = true },
      { '<C-Right>', ':TmuxNavigateRight<CR>', silent = true },
    }
  },

  -- smart split resize
  {
    'mrjones2014/smart-splits.nvim',
    config = function() require('smart-splits').setup({}) end,
    lazy = false,
    keys = {
      { '<A-Left>',  ':SmartResizeLeft  5<CR>' },
      { '<A-Right>', ':SmartResizeRight 5<CR>' },
      { '<A-Up>',    ':SmartResizeUp    5<CR>' },
      { '<A-Down>',  ':SmartResizeDown  5<CR>' },
    }
  },

  -- test running
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux'
    },
    init = function()
      vim.g['test#strategy'] = 'vimux'       -- make test commands execute using vimux
      vim.g['test#python#runner'] = 'pytest' -- have to configure which python runner to use https://github.com/vim-test/vim-test#python
      vim.g['VimuxUseNearest'] = 0           -- don't use an exisiting pane
      vim.g['VimuxHeight'] = '25'
    end,
    lazy = true,
    keys = {
      { '<C-t>', ':w<CR> :TestFile<CR>' },
      { '<C-l>', ':w<CR> :TestNearest<CR>' },
    },
  },

  -- syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('config/treesitter') end,
  },

  -- highlight urls
  {'itchyny/vim-highlighturl'},

  -- lsp
  {
    'junnplus/nvim-lsp-setup',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'neovim/nvim-lspconfig',
      'folke/neodev.nvim',
    },
    config = function() require('config/lsp') end,
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load({
            paths = { '~/dotfiles/nvim/after/snippets' }
          })
        end
      },
    },
    config = function() require('config/nvim-cmp') end,
    lazy = true,
    event = {
      'InsertEnter',
      'CmdlineEnter'
    }
  },

  -- lua utils
  {'nvim-lua/plenary.nvim'},

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
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
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },

  -- gcc and gc + motion to comment
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  },

  -- remember cursor position
  {
    'vladdoster/remember.nvim',
    config = function()
      require('remember')
    end
  },

  -- sublime style multiple cursors. ctrl-n to start
  {
    'mg979/vim-visual-multi',
    init = function()
      -- disable visual-multi-mappings
      -- (it binds to ctrl up/down which I use for navigation)
      vim.g.VM_default_mappings = 0
    end,
    lazy = true,
    keys = {
      { '<C-n>', ':call g:VM_maps["Find Under"][1]', mode = {'n', 'v'}}
    },
  },
}
