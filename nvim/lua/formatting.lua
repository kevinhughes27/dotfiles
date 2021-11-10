require('formatter').setup({
  filetype = {
    go = {
      function()
        return {
          exe = 'goimports',
          stdin = true,
          ignore_exitcode = true,
        }
      end
    }
  }
})

-- format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.go FormatWrite
augroup END
]], true)
