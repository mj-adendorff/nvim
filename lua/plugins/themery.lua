return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = { "tokyonight-day", "tokyonight-storm", "tokyonight-moon", "tokyonight", "catppuccin-latte", "catppuccin-mocha", "catppuccin-macchiato", "catppuccin-frappe", "tokyodark", "onedark", "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus", "default", "nordic", "gruvbox", "oxocarbon", "gruvdark" },
			livePreview = true,
		})
	end,
	keys = {
		{ "<leader>tt", "<cmd>Themery<cr>", desc = "Themery" },
	}
}
