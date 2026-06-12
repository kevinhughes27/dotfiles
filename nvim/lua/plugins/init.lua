-- Plugins
--
-- vim.pack never auto-updates. Manual maintenance:
--   :lua vim.pack.update()              update everything
--   :lua vim.print(vim.pack.get())      inspect what's installed
--   :lua vim.pack.del({ 'name' })       remove a plugin

-- globals that must be set before plugins load
do
  -- vim-visual-multi: disable default mappings (it grabs ctrl up/down which I
  -- use for window navigation) and fix a blink.cmp <CR> clash.
  -- https://github.com/Saghen/blink.cmp/issues/406
  vim.g.VM_default_mappings = 0
  vim.g.VM_maps = { ['I Return'] = '<S-CR>' }
end

-- order matters: dependencies and shared palettes before consumers.
vim.pack.add({
  -- colorscheme, load early so its palette/highlights exist for everything else
  { src = 'https://github.com/navarasu/onedark.nvim' },

  -- icons (tiny-devicons-auto-colors reads onedark.palette)
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/rachartier/tiny-devicons-auto-colors.nvim' },

  -- treesitter
  -- parsers are (re)built via the PackChanged hook in plugins/treesitter.lua
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

  -- completion + snippets
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.2' },
  { src = 'https://github.com/moyiz/blink-emoji.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },

  -- fzf
  { src = 'https://github.com/ibhagwan/fzf-lua' },

  -- nvim-tree
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },

  -- git
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/linrongbin16/gitlinker.nvim' },

  -- ui
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/rafcamlet/tabline-framework.nvim' },
  { src = 'https://github.com/luukvbaal/statuscol.nvim' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },

  -- splits
  { src = 'https://github.com/mrjones2014/smart-splits.nvim' },

  -- testing
  { src = 'https://github.com/vim-test/vim-test' },
  { src = 'https://github.com/preservim/vimux' },

  -- go
  { src = 'https://github.com/crispgm/nvim-go' },

  -- editing niceties
  { src = 'https://github.com/itchyny/vim-highlighturl' },
  { src = 'https://github.com/ibhagwan/smartyank.nvim' },
  { src = 'https://github.com/vladdoster/remember.nvim' },
  { src = 'https://github.com/mg979/vim-visual-multi' },
})

-- only plugins that need configuring are listed
for _, m in ipairs({
  'theme',
  'icons',
  'treesitter',
  'cmp',
  'fzf',
  'git',
  'lualine',
  'tabline',
  'statuscol',
  'markdown',
  'nvim-tree',
  'splits',
  'vim-test',
  'golang',
  'smartyank',
  'remember',
  'visual-multi',
}) do
  require('plugins.' .. m)
end
