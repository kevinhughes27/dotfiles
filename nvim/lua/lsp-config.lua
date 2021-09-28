-- custom language servers
local configs = require "lspconfig/configs"
local util = require "lspconfig/util"

configs.es_ruby = {
  default_config = {
    cmd = { "nc", "localhost", "8341" },
    filetypes = { "ruby", },
    root_dir = util.root_pattern("Gemfile", ".git"),
  },
  docs = {
    description = [[
      Language server for Ruby, backed by Elastic search.
    ]],
    default_config = {
      root_dir = [[root_pattern("Gemfile", ".git")]],
    },
  },
}

local lspconf = require("lspconfig")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

function on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

-- npm install -g typescript-language-server
lspconf["tsserver"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- GO111MODULE=on go get golang.org/x/tools/gopls@latest
lspconf["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
-- chmod +x ~/.local/bin/rust-analyzer
lspconf["rust_analyzer"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

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
lspconf["es_ruby"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- npm install -g bash-language-server
-- lspconf["bashls"].setup({ on_attach = on_attach })

require("lspkind").init({
  symbol_map = {
    Enum = '',
    Constant = '',
    Struct = ''
  }
})
