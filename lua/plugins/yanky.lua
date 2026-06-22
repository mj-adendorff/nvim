return {
	"gbprod/yanky.nvim",
	opts = {
		ring = {
			history_length = 100,
			storage = "shada",
			storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
			sync_with_numbered_registers = true,
			cancel_event = "update",
			ignore_registers = { "_" },
			update_register_on_cycle = false,
			permanent_wrapper = nil,
		},
		picker = {
			select = {
				action = nil, -- nil to use default put action
			},
			telescope = {
				use_default_mappings = true, -- if default mappings should be used
				mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
			},
		},
		system_clipboard = {
			sync_with_ring = true,
			clipboard_register = nil,
		},
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 500,
		},
		preserve_cursor_position = {
			enabled = true,
		},
		textobj = {
			enabled = false,
		},
		keys = {
			{
				"p",
				function()
					require("yanky").put_after()
				end,
				mode = { "n", "x" },
			},
			{
				"P",
				function()
					require("yanky").put("P")
				end,
				mode = { "n", "x" },
			},
			{
				"gp",
				function()
					require("yanky").put("gp")
				end,
				mode = { "n", "x" },
			},
			{
				"gP",
				function()
					require("yanky").put("gp")
				end,
				mode = { "n", "x" },
			},

			{
				"y",
				function()
					require("yanky").yank()
				end,
				mode = { "n", "x" },
			},

			{
				"<c-p>",
				function()
					require("yanky").cycle(1)
				end,
				mode = { "n" },
			},
			{
				"<c-n>",
				function()
					require("yanky").cycle(-1)
				end,
				mode = { "n" },
			},
		},
	},
}
