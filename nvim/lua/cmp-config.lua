local cmp = require("cmp")
local snippet_loader = require("luasnip.loaders.from_vscode")

-- snippets
snippet_loader.lazy_load({
  paths = { "~/dotfiles/nvim/snippets" }
})

-- completion
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace })
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

