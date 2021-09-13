local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

