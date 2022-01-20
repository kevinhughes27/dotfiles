-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

function on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

-- local lspconf = require('lspconfig')

-- npm install -g typescript-language-server
-- lspconf['tsserver'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- GO111MODULE=on go get golang.org/x/tools/gopls@latest
-- lspconf['gopls'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
-- chmod +x ~/.local/bin/rust-analyzer
-- lspconf['rust_analyzer'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- npm install -g pyright
-- lspconf['pyright'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- pip install 'python-lsp-server[all]'
-- lspconf['pylsp'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- npm install -g bash-language-server
-- lspconf['bashls'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

-- require('config/es_ruby')
-- lspconf['es_ruby'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })
