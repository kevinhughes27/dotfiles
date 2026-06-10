-- nvim-treesitter `main` branch (the rewrite). This is a different plugin from
-- the old `master`: no module system, so highlight/indent are wired up by hand
-- and `incremental_selection` no longer exists.
--
-- Requires Neovim 0.12+ and the tree-sitter CLI on PATH for installing parsers.

local ts = require('nvim-treesitter')

-- Ensure these parsers are installed. install() is async and idempotent, so
-- running it every startup is cheap once everything is present.
ts.install({
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'graphql',
  'hcl',
  'html',
  'java',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'promql',
  'python',
  'ruby',
  'rust',
  'sql',
  'toml',
  'terraform',
  'tsx',
  'typescript',
  'vim',
  'yaml',
})

-- Enable highlighting + indentation per buffer, but only when a parser for the
-- buffer's language is actually available (so a not-yet-installed parser won't
-- throw on first launch).
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then return end
    if not pcall(vim.treesitter.start, args.buf, lang) then return end

    -- experimental treesitter indentation
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Update installed parsers whenever vim.pack installs or updates the plugin.
-- (Replaces lazy.nvim's `build = ':TSUpdate'`.)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local d = ev.data
    if d.spec and d.spec.name == 'nvim-treesitter' and (d.kind == 'install' or d.kind == 'update') then
      vim.schedule(function()
        vim.cmd('TSUpdate')
      end)
    end
  end,
})
