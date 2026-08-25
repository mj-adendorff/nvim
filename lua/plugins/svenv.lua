return {
	"AckslD/swenv.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = "python",
	config = function()
		local api = require("swenv.api")

		-- Poetry venvs live under ~/.cache/pypoetry/virtualenvs, outside the repo,
		-- so they never show up in swenv's default venvs_path/pyenv/conda scan.
		local function poetry_venv()
			local path = vim.fn.trim(vim.fn.system("poetry env info --path 2>/dev/null"))
			if vim.v.shell_error == 0 and path ~= "" then
				return {
					name = "poetry (" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ")",
					path = path,
					source = "venv",
				}
			end
			return nil
		end

		require("swenv").setup({
			-- Surface the poetry venv in the manual picker too, alongside the
			-- normal scan results.
			get_venvs = function(venvs_path)
				local venvs = api.get_venvs(venvs_path)
				local poetry = poetry_venv()
				if poetry then
					table.insert(venvs, 1, poetry)
				end
				return venvs
			end,
			post_set_venv = function(venv)
				for _, name in ipairs({ "pyright", "basedpyright", "ty" }) do
					for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
						client.stop()
					end
				end
				vim.notify("swenv: switched to " .. venv.name .. " (:LspRestart if diagnostics look stale)")
			end,
		})

		-- Auto-select this project's poetry venv as soon as a python file is
		-- opened, no picker needed.
		local poetry = poetry_venv()
		if poetry then
			api.set_venv_path(poetry)
		end

		vim.keymap.set("n", "<leader>vs", api.pick_venv, { noremap = true, silent = true, desc = "Select Python venv" })
	end,
}
