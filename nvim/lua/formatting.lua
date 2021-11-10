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
