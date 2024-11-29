-- lsp
--
-- references:
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L405
--
-- pylsp requires `python3-venv` package and fails with an unclear message without it
--
require('mason').setup({
  PATH = 'append',
})

local servers = {
  gopls = {},
  pylsp = {},
  ts_ls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local lspconfig = require('lspconfig')
local mason_lspconfig = require 'mason-lspconfig'

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}
