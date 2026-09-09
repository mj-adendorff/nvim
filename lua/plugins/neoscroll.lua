return {
	"karb94/neoscroll.nvim",
	keys = {
		{ "<C-u>", mode = { "n", "x", "s" } },
		{ "<C-d>", mode = { "n", "x", "s" } },
		{ "<C-b>", mode = { "n", "x", "s" } },
		{ "<C-f>", mode = { "n", "x", "s" } },
		{ "<C-y>", mode = { "n", "x", "s" } },
		{ "<C-e>", mode = { "n", "x", "s" } },
		{ "zt", mode = { "n", "x", "s" } },
		{ "zz", mode = { "n", "x", "s" } },
		{ "zb", mode = { "n", "x", "s" } },
	},
	config = function()
		require("neoscroll").setup()
	end,
}
