local lsp_installer = require('nvim-lsp-installer')

local specific_server_opts = {
  ["sumneko_lua"] = function(opts)
    opts.settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
      },
    }
  end,
}

-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

function on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- configure servers
lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach
  }

  if specific_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    specific_server_opts[server.name](opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

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

-- elastic_ruby_server
----------------------

-- manual setup:
-- docker pull blinknlights/elastic_ruby_server
-- docker volume create elastic_ruby_server-0.2.0 (this could be anything but for now match the vscode extension)
--[[
  docker run \
    -d \
    --rm \
    --name elastic-ruby-server \
    --ulimit memlock=-1:-1 \
    -v elastic_ruby_server-0.2.0:/usr/share/elasticsearch/data \
    -p 8341:8341 \
    -e SERVER_PORT=8341 \
    -e LOG_LEVEL=DEBUG \
    -e HOST_PROJECT_ROOTS="/Users/kevinhughes/clio" \
    --mount "type=bind,source=/Users/kevinhughes/clio,target=/projects/clio,readonly" \
    blinknlights/elastic_ruby_server
]]

-- define custom language server
-- local configs = require 'lspconfig/configs'
-- local util = require 'lspconfig/util'
--
-- configs.es_ruby = {
--   default_config = {
--     cmd = { 'nc', 'localhost', '8341' },
--     filetypes = { 'ruby', },
--     root_dir = util.root_pattern('Gemfile', '.git'),
--   },
--   docs = {
--     description = [[
--       Language server for Ruby, backed by Elastic search.
--     ]],
--     default_config = {
--       root_dir = [[root_pattern('Gemfile', '.git')]],
--     },
--   },
-- }

-- lspconf['es_ruby'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })
