return {
	"niekdomi/conflict.nvim",
	config = function()
		require("conflict").setup({
			default_mappings = {
				current = "cc",
				incoming = "ci",
				both = "cb",
				base = "cB",
				none = false,
				next = "]x",
				prev = "[x",
			},
			show_actions = true, -- Show clickable [Accept Current | ...] labels
			disable_diagnostics = true, -- Disable LSP/Diagnostics while conflicts exist
			highlights = {
				-- Names of highlight groups to use for sections
				current = "DiffText",
				incoming = "DiffAdd",
				ancestor = "DiffChange",
			},
		})
	end,
}
