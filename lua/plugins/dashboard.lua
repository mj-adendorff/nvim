return {
	"glepnir/dashboard-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local config = {}

		config.mru = {
			label = " Recent Files",
			limit = 5,
		}
		config.project = {
			label = " Recent Projects",
			limit = 10,
		}

		config.shortcut = {
			{
				desc = "󰠮  Load Saved Session ",
				action = "SessionRestore",
				group = "@string",
				key = "l",
			},
			{
				desc = "󰠮  Search Session ",
				action = "Autosession search",
				group = "@string",
				key = "s",
			},
			{
				desc = " 󰱼  File ",
				action = "Telescope find_files find_command=rg,--hidden,--files",
				group = "@string",
				key = "fF",
			},
			{
				desc = "   Update ",
				action = "Lazy sync",
				group = "@string",
				key = "u",
			},
			{
				desc = " 󰓅  Profile ",
				action = "Lazy profile",
				group = "@string",
				key = "p",
			},
			{
				desc = " 󰅙  Quit ",
				action = "q!",
				group = "DiagnosticError",
				key = "q",
			},
		}

		config.week_header = { enable = true }
		config.footer = { "", "Woo, time to code." }
		config.packages = { enable = true }

		require("dashboard").setup({
			theme = "hyper",
			config = config,
		})
	end,
	lazy = false,
	priority = 999,
}
