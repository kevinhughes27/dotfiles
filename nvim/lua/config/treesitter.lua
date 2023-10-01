require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection doesn't have to be mapped
      node_incremental = 'v',
      node_decremental = '<A-v>',
      -- shift v is used for making the visual selection the whole line
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
    'markdown',
    'markdown_inline',
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
