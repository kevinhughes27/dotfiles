local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },

  formatting = {
    format = require('lspkind').cmp_format({maxwidth = 50})
  },

  -- NOTE pressing esc will finalize the snippet
  mapping = {
    ['<CR>'] = cmp.mapping.confirm {
       behavior = cmp.ConfirmBehavior.Replace,
       select = true,
    },
    ['<Tab>'] = function(fallback)
       if cmp.visible() then
          cmp.select_next_item()
       elseif require('luasnip').expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
       else
          fallback()
       end
    end,
    ['<S-Tab>'] = function(fallback)
       if cmp.visible() then
          cmp.select_prev_item()
       elseif require('luasnip').jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
       else
          fallback()
       end
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- use buffer source for `/`
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- use cmdline & path source for ':'
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
