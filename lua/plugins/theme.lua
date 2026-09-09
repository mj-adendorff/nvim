return {
	{
		-- Bearded Theme: generated Neovim plugin from the VS Code/Zed repo.
		-- lazy.nvim loads it on demand when a bearded-theme-* colorscheme is requested.
		dir = vim.fn.expand("~/Code/theme/bearded-theme/dist/neovim"),
		name = "bearded-theme",
		lazy = true,
		priority = 1000,
		config = function()
			require("bearded-theme").setup({})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
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
		config = function()
			vim.cmd.colorscheme("tokyodark")
		end,
	},
	{
		"shatur/neovim-ayu",
		lazy = true,
		name = "ayu",
		priority = 1000,
	},
	{
		"darianmorat/gruvdark.nvim",
		lazy = true,
		name = "gruvdark",
		priority = 1000,
	},
	{
		"mj-adendorff/onedark.nvim",
		lazy = true,
		name = "onedark",
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catpuccin",
		lazy = true,
		priority = 1000,
		transparent_background = true,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		name = "oxocarbon",
		lazy = true,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		priority = 1000,
	},
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		lazy = true,
		priority = 1000,
	},
	{
		"AlexvZyl/default.nvim",
		name = "default",
		lazy = true,
		priority = 1000,
		config = function()
			require("default").load()
		end,
	},
	{
		"Aejkatappaja/cendre",
		name = "cendre",
		lazy = true,
		priority = 1000,
		config = function()
			require("cendre").load()
		end,
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
		end,
	},
}
