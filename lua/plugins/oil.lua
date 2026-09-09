local sidebar_width = 35
local sidebar_windows = {} -- tab -> window id of the oil sidebar we created
local target_windows = {} -- tab -> window that was focused when the sidebar opened

-- Only ever treat the split we created as "the sidebar". Matching on
-- filetype == "oil" is wrong once the main window is an oil buffer too
-- (e.g. after `nvim .`, where oil takes over the directory buffer).
local function sidebar_window(tab)
	tab = tab or vim.api.nvim_get_current_tabpage()
	local win = sidebar_windows[tab]
	if win and vim.api.nvim_win_is_valid(win) and vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "oil" then
		return win
	end
	sidebar_windows[tab] = nil
	return nil
end

local function toggle_sidebar()
	local tab = vim.api.nvim_get_current_tabpage()
	local win = sidebar_window(tab)

	if win then
		vim.api.nvim_win_close(win, false)
		sidebar_windows[tab] = nil
		target_windows[tab] = nil
		return
	end

	target_windows[tab] = vim.api.nvim_get_current_win()
	vim.cmd("topleft " .. sidebar_width .. "vsplit")
	sidebar_windows[tab] = vim.api.nvim_get_current_win()
	require("oil").open(vim.uv.cwd())
	vim.api.nvim_win_set_width(0, sidebar_width)
	vim.wo.winfixwidth = true
end

local function select_from_sidebar()
	local oil = require("oil")
	local entry = oil.get_cursor_entry()

	-- Navigate into directories inside the Oil sidebar.
	if not entry or entry.type == "directory" then
		require("oil.actions").select.callback()
		return
	end

	oil.select({
		handle_buffer_callback = function(buf)
			local tab = vim.api.nvim_get_current_tabpage()
			local sidebar = sidebar_window(tab)
			local target = target_windows[tab]

			if not target or not vim.api.nvim_win_is_valid(target) or target == sidebar then
				target = nil
				for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
					if win ~= sidebar then
						target = win
						break
					end
				end
			end

			if not target then
				-- Sidebar is the only window: open the file to its right.
				vim.cmd("botright vsplit")
				target = vim.api.nvim_get_current_win()
			end

			vim.api.nvim_win_set_buf(target, buf)
			vim.api.nvim_set_current_win(target)
		end,
	})
end

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Must not be lazy-loaded: with default_file_explorer = true, oil has to be
	-- present at startup to take over directory buffers (`nvim .`). Loading it
	-- later hijacks the already-open directory buffer out from under the sidebar.
	lazy = false,
	keys = {
		{
			"<leader>e",
			toggle_sidebar,
			desc = "Toggle explorer sidebar",
		},
	},
	opts = {
		default_file_explorer = true,
		columns = { "icon" },
		keymaps = {
			["<CR>"] = {
				callback = select_from_sidebar,
				desc = "Open in editor",
			},
			["H"] = {
				"actions.toggle_hidden",
				mode = "n",
				desc = "Toggle hidden files",
			},
		},
	},
}
