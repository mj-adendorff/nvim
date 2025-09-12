return {
	"mason-org/mason.nvim",
	version = "^1.0.0",
	opts = {
		ensure_installed = { "stylua", "rust-analyser", "ts_ls", "gopls", "ruff", "clangd", "pyright", "jdtls" },
	},
}
