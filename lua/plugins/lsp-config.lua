return {
	"neovim/nvim-lspconfig",
	ft = { "python", "svelte", "typescript", "javascript" },
	dependencies = { "saghen/blink.cmp" },
	--dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		-- blink
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- nvim cmp
		--local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
		-- Pin the NixOS binaries: swenv puts the venv's bin/ first on PATH, and its
		-- pip-wheel ruff/ty can't run on NixOS.
		vim.lsp.config("ruff", { capabilities = capabilities, cmd = { "/run/current-system/sw/bin/ruff", "server" } })
		--vim.lsp.config("eslint", { capabilities = capabilities })
		vim.lsp.config("ty", {
			capabilities = capabilities,
			cmd = { "/run/current-system/sw/bin/ty", "server" },
			settings = { ty = { diagnosticMode = "openFilesOnly" } },
		})
		-- enabled lsp plugins
		--vim.lsp.enable("lua_ls")
		--vim.lsp.enable("jdtls")
		vim.lsp.enable("ruff")
		--vim.lsp.enable("ts_ls")
		--vim.lsp.enable("basedpyright")
		vim.lsp.enable("ty")

		-- Neovim only clears a detaching client's push diagnostics; its pull
		-- diagnostics linger while another pull client (ruff) stays attached, e.g.
		-- the pre-venv ty's unresolved imports after swenv restarts it.
		vim.api.nvim_create_autocmd("LspDetach", {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client then
					return
				end
				local prefix = "nvim.lsp." .. client.name .. "." .. client.id .. "."
				for ns, meta in pairs(vim.diagnostic.get_namespaces()) do
					if vim.startswith(meta.name, prefix) then
						vim.diagnostic.reset(ns, ev.buf)
					end
				end
			end,
		})

		-- svelte
		vim.lsp.config("svelte", { capabilities = capabilities })
		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.enable({ "svelte", "ts_ls" })
		-- svelte-language-server does not watch .ts/.js imports; tell it on save
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				for _, c in ipairs(vim.lsp.get_clients({ name = "svelte" })) do
					c:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				end
			end,
		})
		--vim.lsp.enable("eslint")
	end,
}
