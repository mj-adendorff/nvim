return {
	"nvim-java/nvim-java",
	enabled = false,
	config = function()
		require("java").setup()
	end,
}
