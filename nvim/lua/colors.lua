-- Colors

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
