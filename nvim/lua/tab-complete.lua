local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
  else
      return false
  end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
  elseif check_back_space() then
      return t "<Tab>"
  else
      return fn["coc#refresh"]()
  end
end

-- Make <CR> select completion item without dropping to a new line
vim.api.nvim_exec(
[[
  inoremap <silent><expr> <CR> coc#_selected() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]],
true)
