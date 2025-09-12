return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local wk = require("which-key")
		wk.setup()
		wk.add({
			{ "<leader>r", group = "lspSaga" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>t", group = "Themery" },
			{ "<leader>g", group = "Lazygit" },
			{ "<leader>d", group = "Diffview" },
		})
	end,
}
