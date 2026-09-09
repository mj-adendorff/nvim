return {
	"mason-org/mason.nvim",
	version = "^1.0.0",
	-- event-lazy rather than cmd-only: mason-nvim-dap (nvim-dap.lua) also
	-- needs mason initialized whenever *it* loads, not just on `:Mason`
	event = "VeryLazy",
	opts = {
		ensure_installed = { "stylua", "rust-analyser", "ts_ls", "gopls", "ruff", "clangd", "pyright", "jdtls" },
	},
}
