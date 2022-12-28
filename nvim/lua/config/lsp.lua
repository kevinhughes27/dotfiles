local lsp_setup = require('lsp-setup')
local neodev = require('neodev')

neodev.setup({})

lsp_setup.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,

  servers = {
    sumneko_lua = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    pylsp = {},
    tsserver = {},
  }
})
