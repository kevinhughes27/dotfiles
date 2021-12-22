vim.api.nvim_exec([[
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
    \ 'highlighter': wilder#basic_highlighter(),
    \ 'highlights': {
    \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#61afef'}]),
    \   'default': '#282c34',
    \ },
    \ 'left': [
    \   ' ', wilder#popupmenu_devicons(),
    \ ],
    \ 'right': [
    \   ' ', wilder#popupmenu_scrollbar(),
    \ ],
    \ 'min_width': '20%',
    \ })))
]], true)
