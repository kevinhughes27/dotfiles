return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {
                'vim',
                'require',
              },
            },
          },
        },
      })

      -- pylsp requires `python3-venv` package and fails with an unclear message without it
      vim.lsp.config('pylsp', {
        cmd = { 'pylsp' },
        cmd_env = {
          VIRTUAL_ENV = '.venv',
        },
        root_markers = { 'pyproject.toml', 'requirements.txt', '.git' },
        filetypes = { 'python' },
      })

      vim.lsp.config('ruff', {
        cmd = { 'ruff', 'server' },
        root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
        filetypes = { 'python' },
      })

      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        root_markers = { 'go.mod', '.git' },
        filetypes = { 'go' },
      })

      -- on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { noremap = true, silent = true, buffer = ev.buf }

          vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.keymap.set('n', 'ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.keymap.set('n', '<RightMouse>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

          vim.diagnostic.config({virtual_text = true})
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
}
