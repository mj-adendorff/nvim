return {
	{
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			cmd = "Telescope",
			keys = {
				{ "<leader><leader>", desc = "Find Files" },
				{ "<leader>/", desc = "Live grep" },
				{ "<leader>bb", desc = "Find buffers" },
				{ "<leader>bg", desc = "Git files" },
			},
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
				vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live Greb" })
				vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Find buffers" })
				vim.keymap.set("n", "<leader>bg", builtin.git_files, { desc = "Git files" })

				-- vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			event = "VeryLazy",
			config = function()
				require("telescope").setup({
					defaults = {
						mappings = {
							i = {
								["<C-S-V>"] = { "<C-r>+", type = "command" },
							},
						},
						file_ignore_patterns = {
							"tests/",
						},
					},
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown({
								-- even more opts
							}),
						},
					},
				})
				-- To get ui-select loaded and working with telescope, you need to call
				-- load_extension, somewhere after setup function:
				require("telescope").load_extension("ui-select")
			end,
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		-- nothing in this config calls load_extension("fzf") yet, so this
		-- was never actually wired up; lazy=true until it is
		lazy = true,
	},
}
