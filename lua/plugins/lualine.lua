return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		local tr = require("nvim-treesitter")

		local function location()
			return tr.statusline({ type_patterns = { "class" } })
		end

		-- Lsp server name .
		local function lsp()
			local msg = 'No Active Lsp'
			local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end
		-- icon = ' LSP:',
		-- color = { fg = '#ffffff', gui = 'bold' },

		require("lualine").setup({
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_c = { location, lsp },
				lualine_x = { "filename" },
			},
		})
	end,
}
