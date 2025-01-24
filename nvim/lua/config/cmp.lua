local blink = require('blink-cmp')

require('luasnip.loaders.from_vscode').lazy_load({
  paths = { '~/dotfiles/nvim/after/snippets' }
})

blink.setup({
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
          return ctx.mode ~= 'cmdline' and not blink.snippet_active({ direction = 1 })
        end,
        auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end,
      }
    }
  },

  snippets = { preset = 'luasnip' },

  sources = {
    default = {
      'lazydev',
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
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },

})
