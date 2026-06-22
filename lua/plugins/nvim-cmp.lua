return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		--"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	opts = function()
		-- Register nvim-cmp lsp capabilities
		vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()
		local auto_select = true
		return {
			auto_brackets = {}, -- configure any filetype to auto add brackets
			-- completion = {
			-- 	completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			-- },
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			mapping = cmp.mapping.preset.insert({
				["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			}),
			sorting = {
				priority_weight = 1.0,
				comparators = {
					-- compare.score_offset, -- not good at all
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
					cmp.config.compare.offset,
					cmp.config.compare.order,
					-- compare.scopes, -- what?
					-- compare.sort_text,
					-- compare.exact,
					-- compare.kind,
					-- compare.length, -- useless
				},
			},
			-- formatting = {
			-- 	format = function(entry, item)
			-- 		local widths = {
			-- 			abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
			-- 			menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
			-- 		}
			--
			-- 		for key, width in pairs(widths) do
			-- 			if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
			-- 				item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
			-- 			end
			-- 		end
			--
			-- 		return item
			-- 	end,
			-- },
			-- experimental = {
			-- 	-- only show ghost text when we show ai completions
			-- 	ghost_text = vim.g.ai_cmp and {
			-- 		hl_group = "CmpGhostText",
			-- 	} or false,
			-- },
			-- sorting = defaults.sorting,
		}
	end,
}
