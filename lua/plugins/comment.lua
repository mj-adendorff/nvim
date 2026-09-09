return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "x", "o" }, desc = "Comment linewise" },
		{ "gb", mode = { "n", "x", "o" }, desc = "Comment blockwise" },
	},
	opts = {
		-- add any options here
	},
	config = function()
		require("Comment").setup()
	end,
}
