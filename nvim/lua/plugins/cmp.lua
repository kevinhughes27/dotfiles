-- snippets (loaded by blink via the luasnip preset below)
require('luasnip.loaders.from_vscode').lazy_load({
  paths = { '~/dotfiles/nvim/after/snippets' }
})

require('blink.cmp').setup({
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  completion = {
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
        end,
        auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end,
      }
    }
  },

  snippets = { preset = 'luasnip' },

  sources = {
    default = {
      'lsp',
      'snippets',
      'buffer',
      'emoji',
      'path'
    },

    providers = {
      emoji = {
        module = 'blink-emoji',
        name = 'Emoji',
        min_keyword_length = 3,
      },
      buffer = {
        max_items = 2,
        min_keyword_length = 3,
      },
      cmdline = {
        min_keyword_length = 2,
      },
    },
  },
})
