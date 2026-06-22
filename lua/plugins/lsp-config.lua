return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		-- blink
		--local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- nvim cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- local function installer(package_name)
		-- 	local mr = require("mason-registry")
		-- 	if mr.has_package(package_name) then
		-- 		local p = mr.get_package(package_name)
		-- 		if not p:is_installed() then
		-- 			p:install()
		-- 		end
		-- 		vim.lsp.config(package_name, { capabilities = capabilities })
		-- 		vim.lsp.enable(package_name)
		-- 	end
		-- end
		--
		-- local ensure_installed = { "ty", "ruff", "pyright" }
		-- for _, lsp in ipairs(ensure_installed) do
		-- 	installer(lsp)
		-- end

		-- setup lsp with blink
		--vim.lsp.config("jdtls", { capabilities = capabilities })
		--vim.lsp.config("lua_ls", { capabilities = capabilities })
		--vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.config("ruff", { capabilities = capabilities })
		--vim.lsp.config("eslint", { capabilities = capabilities })
		vim.lsp.config("ty", { capabilities = capabilities })
		-- enabled lsp plugins
		--vim.lsp.enable("lua_ls")
		--vim.lsp.enable("jdtls")
		vim.lsp.enable("ruff")
		--vim.lsp.enable("ts_ls")
		--vim.lsp.enable("basedpyright")
		vim.lsp.enable("ty")
		--vim.lsp.enable("eslint")
	end,
}
