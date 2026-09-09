local highlight = {
	"CursorColumn",
	"Whitespace",
}
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- indent = { highlight = highlight, char = "" },
		-- whitespace = {
		-- 	highlight = highlight,
		-- 	remove_blankline_trail = false,
		-- },
		exclude = {
			filetypes = {
				"dashboard",
			},
		},
		scope = { enabled = true },
	},
}
