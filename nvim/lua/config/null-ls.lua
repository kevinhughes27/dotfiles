local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports, -- go install golang.org/x/tools/cmd/goimports@latest
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end
})
