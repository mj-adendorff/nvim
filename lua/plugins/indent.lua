local highlight = {
	"CursorColumn",
	"Whitespace",
}
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	enabled = false,
	opts = {
		indent = { highlight = highlight, char = "" },
		whitespace = {
			highlight = highlight,
			remove_blankline_trail = false,
		},
		scope = { enabled = true },
	}
}
