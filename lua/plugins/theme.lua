return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		enabled = true,
		config = function()
			require("tokyonight").setup()
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"darianmorat/gruvdark.nvim",
		lazy = false,
		name = "gruvdark",
		priority = 1000,
	},
	{
		"mj-adendorff/onedark.nvim",
		lazy = false,
		name = "onedark",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catpuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		name = 'oxocarbon',
		lazy = false,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		name = 'kanagawa',
		lazy = false,
		priority = 1000,
	},
	{
		'AlexvZyl/nordic.nvim',
		name = "nordic",
		lazy = false,
		priority = 1000,
	},
	{
		'AlexvZyl/default.nvim',
		name = "default",
		lazy = false,
		priority = 1000,
		config = function()
			require('default').load()
		end
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
		lazy = true,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = true,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end
	}
}
