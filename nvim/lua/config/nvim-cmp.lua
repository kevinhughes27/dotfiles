local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')

local cmp_single_entry = function()
  local entries = cmp.get_entries()
  local count = 0
  for _ in pairs(entries) do count = count + 1 end
  return count == 1
end

local autoconfirm = function()
  local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys(key, "i", false)
end

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
        if cmp_single_entry() then autoconfirm() end
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

    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length=5, max_item_count=2 },
    { name = 'emoji' },
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
