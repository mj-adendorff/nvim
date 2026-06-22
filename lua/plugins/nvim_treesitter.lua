return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"c",
			"go",
			"toml",
			"python",
			"rust",
			"java",
			"javascript",
			"vimdoc",
		})
		local config = require("nvim-treesitter")
		config.setup({
			-- highlight = { enable = true },
			-- indent = { enable = true },
		})
	end,
}
