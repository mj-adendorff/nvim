return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	enabled = true,
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
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
			window = { border = "rounded" },
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },

			keyword = { range = "full" },

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},

			menu = {
				border = "rounded",

				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,

				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(item)
								local kind = require("lspkind").symbol_map[item.kind] or ""
								return kind .. " "
							end,
							highlight = "CmpItemKind",
						},
						label = {
							text = function(item)
								return item.label
							end,
							highlight = "CmpItemAbbr",
						},
						kind = {
							text = function(item)
								return item.kind
							end,
							highlight = "CmpItemKind",
						},
					},
				},
			},
		},

		-- (Default) list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					score_offset = 0, -- Boost/penalize the score of the items
				},
				path = {
					min_keyword_length = 0,
				},
				snippets = {
					min_keyword_length = 2,
				},
				buffer = {
					min_keyword_length = 5,
					max_items = 5,
				},
			},
		},
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
			implementation = "lua",
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
