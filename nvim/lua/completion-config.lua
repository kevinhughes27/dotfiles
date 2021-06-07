vim.o.completeopt = "menuone,noselect"

local lspconf = require("lspconfig")

function on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

-- npm install -g typescript-language-server
lspconf["tsserver"].setup({ on_attach = on_attach })

-- GO111MODULE=on go get golang.org/x/tools/gopls@latest
lspconf["gopls"].setup({ on_attach = on_attach })

-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
-- chmod +x ~/.local/bin/rust-analyzer
lspconf["rust_analyzer"].setup({ on_attach = on_attach })

-- npm install -g bash-language-server
lspconf["bashls"].setup({ on_attach = on_attach })

require("lspkind").init({
  symbol_map = {
    Enum = '',
    Constant = '',
    Struct = ''
  }
})

require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "disable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = {kind = "﬘", true},
    calc = false,
    vsnip = false,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = false,
    snippets_nvim = false,
    treesitter = false
  }
})

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
