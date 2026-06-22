return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},
	enabled = false,
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = {
			preset = "default",
			["<S-Tab>"] = { "select_and_accept" },
			["<C-j>"] = { "select_next" },
			["<C-k>"] = { "select_prev" },
		},

		-- (Default) Only show the documentation popup when manually triggered
		--
		signature = {
			enabled = true,
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = { auto_show = true },
			keyword = { range = "full" },
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
		},

		-- (Default) list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = { default = { "lsp", "path" } },
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<Right>"] = false,
				["<Left>"] = false,
			},
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"`
		-- See the fuzzy documentation for more information
		fuzzy = {
			implementation = "rust",
			sorts = {
				"exact",
				"score",
				"sort_text",
				"label",
			},
		},
	},

	opts_extend = { "sources.default" },
}
