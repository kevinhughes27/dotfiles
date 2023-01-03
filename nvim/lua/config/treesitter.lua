require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    -- 'markdown', -- messes up my conceals
    'python',
    'ruby',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml'
  },
})
