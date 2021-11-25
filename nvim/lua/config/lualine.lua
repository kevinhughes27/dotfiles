require('lualine').setup({
  options = {
    theme = 'onedark',
    disabled_filetypes = {'NvimTree'},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { {'filename', path = 1, file_status = true} },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
