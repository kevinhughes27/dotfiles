-- lsp
-- :checkhealth vim.lsp
--

-- Lua LSP
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  root_markers = { ".git" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    },
  },
})

-- Python LSP
vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  cmd_env = {
    VIRTUAL_ENV = ".venv",
  },
  root_markers = { "pyproject.toml", "requirements.txt", ".git" },
  filetypes = { "python" },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  filetypes = { "python" },
})

-- Go LSP
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  root_markers = { "go.mod", ".git" },
  filetypes = { "go" },
})

-- enable
vim.lsp.enable({
  'lua_ls',
  'pylsp',
  'ruff',
  'gopls',
})

-- Configure inlay hints
vim.lsp.inlay_hint.enable(true)

-- Global LSP settings
vim.lsp.set_log_level("warn")

-- on attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    -- LSP keymaps
    vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = {
        severity = vim.diagnostic.severity.WARN,
        format = function(diagnostic)
          return string.format("%s: %s", diagnostic.source, diagnostic.message)
        end,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end,
})
