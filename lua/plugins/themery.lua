return {
	"zaldih/themery.nvim",
	-- Must load at startup: Themery restores the saved colorscheme when its
	-- module is first required. With lazy = true the selection is saved but
	-- never applied on the next launch.
	lazy = false,
	dependencies = { "bearded-theme" },
	config = function()
		local themes = {
			"tokyonight-day",
			"tokyonight-storm",
			"tokyonight-moon",
			"tokyonight",
			"catppuccin-latte",
			"catppuccin-mocha",
			"catppuccin-macchiato",
			"catppuccin-frappe",
			"tokyodark",
			"onedark",
			"ayu",
			"kanagawa",
			"kanagawa-wave",
			"kanagawa-dragon",
			"kanagawa-lotus",
			"default",
			"nordic",
			"gruvbox",
			"oxocarbon",
			"gruvdark",
			"cendre",
		}

		-- Add every Bearded Theme variant (64 of them) from the generated plugin
		local ok, bearded = pcall(require, "bearded-theme")
		if ok then
			for _, t in ipairs(bearded.themes()) do
				table.insert(themes, { name = t.name, colorscheme = t.colorscheme })
			end
		end

		require("themery").setup({
			themes = themes,
			livePreview = true,
		})
	end,
	keys = {
		{ "<leader>tt", "<cmd>Themery<cr>", desc = "Select theme" },
	},
}
