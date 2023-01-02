return {
  -- colorscheme
  {
    'navarasu/onedark.nvim',
    priority=1000,
    config = function()
      local onedark = require('onedark')

      onedark.setup({
        transparent = true,
        highlights = {
          PmenuSel = {bg = '$green'},
          TabLineSel = {bg = '$blue'},
          HighlightUrl = {fg = '$blue'},
          YankPost = {fg = '$black', bg='$blue'},
          NvimTreeWinSeparator = {fg = '#3e4452'},
          CmpItemAbbrMatch = {fg = '#569CD6'},
          CmpItemAbbrMatchFuzzy = {fg ='#569CD6'},
          CmpItemKindClass = {fg = '$cyan'},
          CmpItemKindMethod = {fg = '$blue'},
          CmpItemKindVariable = {fg = '$purple'},
          CmpItemKindFunction = {fg = '$blue'},
          CmpItemKindKeyword = {fg = '$red'},
          CmpItemKindText = {fg = '$fg'},
        }
      })

      onedark.load()
    end
  },

  -- icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        override = {
          md = {
            icon = '',
            color = '#6d8086',
            name = 'Md'
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
          };
        };
      }
    end
  }
}
