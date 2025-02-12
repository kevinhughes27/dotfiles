return {
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    config = function()
      require('tiny-devicons-auto-colors').setup({
        colors = require('onedark.palette')['dark']
      })
    end,

    dependencies = {
      {
        'nvim-tree/nvim-web-devicons',
        opts = {
          override = {
            md = {
              icon = '󰧮',
              color = '#6d8086',
              name = 'Md'
            },
            toml = {
              icon = "",
              color = "#6d8086",
              name = "Toml",
            },
            rb = {
              icon = '',
              color = '#e06c75',
              name = 'Rb'
            },
            erb = {
              icon = '',
              color = '#e06c75',
              name = 'Erb',
            },
            rake = {
              icon = '',
              color = '#e06c75',
              name = 'Rake'
            },
            ['config.ru'] = {
              icon = '',
              color = '#e06c75',
              name = 'ConfigRu'
            },
            sqlite3 = {
              icon = '',
              color = '#dad8d8',
              name = 'sqlite',
            },
          },
          override_by_filename = {
            ['bashrc'] = {
              icon = '',
              color = '#89e051',
              cterm_color = '113',
              name = 'Bashrc',
            },
            ['gitconfig'] = {
              icon = '',
              color = '#41535b',
              cterm_color = '239',
              name = 'GitConfig',
            },
            ['vimrc'] = {
              icon = '',
              color = '#019833',
              cterm_color = '28',
              name = 'Vimrc',
            },
            ['gitignore'] = {
              icon = '',
              color = '#41535b',
              cterm_color = '239',
              name = 'GitIgnore'
            },
            ['zshrc'] = {
              icon = '',
              color = '#89e051',
              cterm_color = '113',
              name = 'Zshrc',
            },
          },
        },
      },
    },
  },
}
