local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  -- use TAB and S-TAB to cycle through snippet nodes
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<ESC>'] = cmp.mapping.abort(),

    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
    },
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },

  formatting = {
    format = lspkind.cmp_format({maxwidth = 50})
  },

  window = {
    completion = {
      border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
    },
    documentation = {
      border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
    }
  }
})

local cmdline_formatting = {
  fields = { 'abbr' },
  format = function(_, vim_item)
    vim_item.menu = ""
    vim_item.kind = ""
    return vim_item
  end,
}

-- use buffer source for `/`
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  formatting = cmdline_formatting,
  sources = {
    { name = 'buffer' }
  }
})

-- use cmdline and path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  formatting = cmdline_formatting,
  sources = {
    { name = 'path' },
    { name = 'cmdline', max_item_count=15 }
  }
})
