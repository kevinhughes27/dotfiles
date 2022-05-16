-- lsp setup
require('nvim-lsp-setup').setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),

  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,

  servers = {
    sumneko_lua = require('lua-dev').setup(),
    pylsp = {},
    tsserver = {},
  }
})

-- null-ls
-- go install golang.org/x/tools/cmd/goimports@latest
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.formatting.gofmt,
    require('null-ls').builtins.formatting.goimports,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
})
