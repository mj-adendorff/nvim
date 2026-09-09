return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	-- must load early (not cmd/keys-only) so it's already recording yank
	-- history by the time you press <leader>c to browse it
	event = "VeryLazy",
	config = function()
		require("neoclip").setup()
		vim.keymap.set("n", "<leader>c", ":Telescope neoclip<CR>", { desc = "Neoclip" })
	end,
}
