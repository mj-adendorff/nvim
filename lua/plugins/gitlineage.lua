return {
	"lionyxml/gitlineage.nvim",
	dependencies = {
		"sindrets/diffview.nvim", -- optional, for open_diff feature
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitlineage").setup()
	end
}
