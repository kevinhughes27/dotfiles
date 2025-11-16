return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        highlight = { enable = true, },
        indent = { enable = true },
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
          'hcl',
          'html',
          'java',
          'javascript',
          'json',
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
          'terraform',
          'tsx',
          'typescript',
          'vim',
          'yaml'
        },
      })
    end
  }
}
