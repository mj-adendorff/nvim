return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		local function lsp()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			return clients[1] and clients[1].name or ""
		end

		require("lualine").setup({
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_c = { lsp },
				lualine_x = { "filename" },
			},
		})
	end,
}
