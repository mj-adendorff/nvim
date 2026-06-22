return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "ruff_format" },
				html = { "npx prettier" },
				c = { "clang-format" },
				javascript = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
			notify_on_error = true,
			log_level = vim.log.levels.ERROR,
		})
	end,
}
