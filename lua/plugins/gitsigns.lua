return {
	"lewis6991/gitsigns.nvim",
	keys = {
		{
			"<leader>bm",
			function()
				local gs = require("gitsigns")

				if vim.g.gitsigns_merge_base_active then
					gs.reset_base(true)
					vim.g.gitsigns_merge_base_active = false
					vim.notify("Gitsigns: Normal mode")
					return
				end

				local result = vim.system({
					"git",
					"merge-base",
					"main",
					"HEAD",
				}):wait()

				if result.code ~= 0 then
					vim.notify("Could not find merge-base", vim.log.levels.ERROR)
					return
				end

				local base = vim.trim(result.stdout)

				gs.change_base(base, true)
				vim.g.gitsigns_merge_base_active = true
				vim.notify("Gitsigns: Comparing against main merge-base")
			end,
			desc = "Toggle merge-base comparison",
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			current_line_blame = false,
		})
	end,
}
