return {
	"sindrets/diffview.nvim",
	lazy = false,
	keys = {
		{ "<leader>dh", "<cmd>DiffviewFileHistory %s<cr>", desc = "Diffview file history" },
		{ "<leader>dd", "<cmd>Diffview main<cr>",          desc = "Diffview comapare to main" },
	}
}
