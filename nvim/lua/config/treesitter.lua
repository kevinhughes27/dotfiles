require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
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
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'go',
    'graphql',
    'groovy',
    'hcl',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'promql',
    'python',
    'ruby',
    'rust',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml'
  },
})
