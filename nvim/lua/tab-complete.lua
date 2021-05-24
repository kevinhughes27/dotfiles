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
    return vim.fn["coc#refresh"]()
  end
end

_G.tab_complete_enter = function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["coc#_select_confirm"]()
  else
    return t "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
  end
end

_G.show_documentation = function()
  if vim.fn["coc#rpc#ready"]() then
    vim.api.nvim_exec("call CocActionAsync('doHover')", true)
  end
end
