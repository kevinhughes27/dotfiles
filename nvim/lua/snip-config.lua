local ls = require("luasnip")
local loader = require("luasnip.loaders.from_vscode")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})

ls.snippets = {
	-- When trying to expand a snippet, luasnip first searches the tables for
	-- each filetype specified in 'filetype' followed by 'all'.
	-- If ie. the filetype is 'lua.c'
	--     - luasnip.lua
	--     - luasnip.c
	--     - luasnip.all
	-- are searched in that order.
	all = {
		-- trigger is fn.
		s("fn", {
			-- Simple static text.
			t("//Parameters: "),
			-- function, first parameter is the function, second the Placeholders
			-- whose text it gets as input.
			f(copy, 2),
			t({ "", "function " }),
			-- Placeholder/Insert.
			i(1),
			t("("),
			-- Placeholder with initial text.
			i(2, "int foo"),
			-- Linebreak
			t({ ") {", "\t" }),
			-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
			i(0),
			t({ "", "}" }),
    })
  },
}

loader.lazy_load({
  paths = { "~/dotfiles/nvim/snippets" }
})
