return {
  {
    'navarasu/onedark.nvim',
    priority=100,
    config = function()
      require('onedark').setup({
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
        },
        code_style = {
          comments = 'none',
        }
      })
      require('onedark').load()
    end
  }
}
