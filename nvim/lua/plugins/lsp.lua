return {
  -- neodev
  {
    'folke/neodev.nvim',
    priority = 100,
    config = function()
      require('neodev').setup({})
    end
  },

  -- lsp
  {
    'junnplus/nvim-lsp-setup',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('lsp-setup').setup({
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
                workspace = {
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
    end
  },

  -- null-ls (formatting)
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
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
    end
  },
}
