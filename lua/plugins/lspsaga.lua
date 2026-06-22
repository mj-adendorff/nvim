return {
	"nvimdev/lspsaga.nvim",
	enabled = true,
	lazy = false,
	opts = {
		symbol_in_winbar = {
			enabled = false,
		},
	},
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enabled = false,
			},
			finder = {
				keys = {
					toggle_or_open = "e",
					shuttle = "<S-W>",
				},
				default = "def+ref+imp",
			},
			callhierarchy = {
				keys = {
					shuttle = "<S-W>",
				},
			},
			lightbulb = {
				enable = false,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	keys = {
		{ "<leader>ri", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming Calls (Find usages)" },
		{ "<leader>ro", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing calls (calls inside function)" },
		{ "<leader>rf", "<cmd>Lspsaga finder<cr>", desc = "Finder" },
		{ "<leader>rd", "<cmd>Lspsaga peek_definition<cr>", desc = "Definition" },
		{ "<leader>gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to Definition" },
		{ "<leader>rl", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
		{ "<leader>ra", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
		{ "<leader>rh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },
		{ "<leader>rr", "<cmd>Lspsaga rename<cr>", desc = "Hover" },
		{ "<C-k>", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },
	},
}
