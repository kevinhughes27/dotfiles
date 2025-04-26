-- lsp
-- :checkhealth vim.lsp
--
vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  root_markers = { "pyproject.toml", "requirements.txt", ".git" },
  filetypes = { "python" },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  filetypes = { "python" },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  root_markers = { "go.mod", ".git" },
  filetypes = { "go" },
})

-- enable
vim.lsp.enable({
  'pylsp',
  'ruff',
  'gopls',
})

-- on attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- diagnostic text does not seem to be working yet
    -- works in go but not python. maybe ruff clobbering?
    -- go is only working after save. might be something else doing it
    vim.diagnostic.config({virtual_text = true})
  end,
})
