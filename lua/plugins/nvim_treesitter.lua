return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "c", "go", "toml", "python", "rust", "java", "javascript", "vimdoc" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
