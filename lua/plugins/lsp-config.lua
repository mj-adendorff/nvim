return {
	"neovim/nvim-lspconfig",
	dependencies = { 'saghen/blink.cmp' },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		lspconfig.jdtls.setup({ capabilities = capabilities })
		lspconfig.lua_ls.setup({ capabilities = capabilities })
		lspconfig.ts_ls.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.ruff.setup({})
		lspconfig.clangd.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
		-- vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
	end,
}
