require('formatter').setup({
  filetype = {
    go = {
      function()
        return {
          exe = 'goimports',
          stdin = true,
        }
      end
    }
  }
})

--- strip trailing spaces on save
vim.api.nvim_command('autocmd BufWritePre * :%s/\\s\\+$//e')

-- format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.go FormatWrite
augroup END
]], true)

