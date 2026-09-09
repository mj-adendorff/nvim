return {
	"AckslD/swenv.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = "python",
	config = function()
		local api = require("swenv.api")

		local function poetry_entry(path)
			return {
				name = "poetry (" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ")",
				path = path,
				source = "venv",
			}
		end

		-- Poetry venvs live under ~/.cache/pypoetry/virtualenvs, outside the repo,
		-- so they never show up in swenv's default venvs_path/pyenv/conda scan.
		-- Synchronous variant, only used by the manual picker.
		local function poetry_venv()
			local res = vim.system({ "poetry", "env", "info", "--path" }, { text = true }):wait()
			local path = vim.trim(res.stdout or "")
			if res.code == 0 and path ~= "" then
				return poetry_entry(path)
			end
			return nil
		end

		-- Restart the Python LSPs so they pick up the new interpreter. By the time
		-- the venv is set the LSP is usually already attached, so stopping alone
		-- would leave the buffer without a server.
		local function restart_python_lsps()
			for _, name in ipairs({ "pyright", "basedpyright", "ty" }) do
				if #vim.lsp.get_clients({ name = name }) > 0 then
					vim.lsp.enable(name, false)
					vim.lsp.enable(name, true)
				end
			end
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
				restart_python_lsps()
				vim.notify("swenv: switched to " .. venv.name)
			end,
		})

		-- Auto-select this project's poetry venv as soon as a python file is
		-- opened, no picker needed. Runs in the background: `poetry env info`
		-- takes 250ms+ and used to block startup.
		vim.system({ "poetry", "env", "info", "--path" }, { text = true }, function(res)
			local path = vim.trim(res.stdout or "")
			if res.code == 0 and path ~= "" then
				vim.schedule(function()
					api.set_venv_path(poetry_entry(path))
				end)
			end
		end)

		vim.keymap.set("n", "<leader>vs", api.pick_venv, { noremap = true, silent = true, desc = "Select Python venv" })
	end,
}
