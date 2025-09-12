-- VIM SETUP
--vim.cmd("set copyindent")
--vim.cmd("set noexpandtab")
--vim.cmd("set preserveindent")
--vim.cmd("set softtabstop=0")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=-1")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set colorcolumn=120")
vim.cmd("set noexpandtab")
-- hard tabs for python files
vim.cmd("autocmd FileType python setlocal noexpandtab")
vim.cmd("set relativenumber")
vim.cmd("set mousescroll=ver:10")

-- session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- if using neovide
if vim.g.neovide then
	-- vim.o.guifont = "0xProto Nerd Font Mono:h10"
	vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h11"
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_refresh_rate = 120
	vim.keymap.set({ "n", "x" }, "<C-S-C>", '"+y', { desc = "Copy system clipboard" })
	vim.keymap.set({ "n", "x" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
	vim.g.neovide_input_use_logo = 1
	vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })
	vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
	vim.api.nvim_set_keymap("v", "<sc-v>", '"+P', { noremap = true })
	-- vim.api.nvim_set_keymap("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
	vim.api.nvim_set_keymap("c", "<sc-v>", "<C-R>0", { noremap = true })
	vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>l"+Pli', { noremap = true })
	vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
end

-- terraform
vim.filetype.add({
	extension = {
		tf = "terraform"
	}
})

vim.opt.inccommand = "split"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"

-- uncomment these line to show invisibles
-- vim.cmd("set list")
-- vim.cmd("set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<")

vim.o.number = true
-- vim.o.relativenumber = true
vim.g.mapleader = " "       -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.opt.guicursor = "i:ver20-blinkon1,a:blinkon1"
-- MAPPINGS

vim.keymap.set("n", "X", ":lua vim.diagnostic.open_float(nil, { focusable = false })<CR>",
	{ noremap = true, silent = true })

--- movement
-- vim.keymap.set("n", "W", "<C-w>W", { noremap = true, silent = true })
vim.keymap.set("n", "H", "<C-w><left>", { noremap = true, silent = true })
vim.keymap.set("n", "L", "<C-w><right>", { noremap = true, silent = true })
vim.keymap.set("n", "J", "<C-w><down>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<C-w><up>", { noremap = true, silent = true })

-- clear search
vim.keymap.set("n", "<M-l>", "<CR>:noh<CR>", { noremap = true, silent = true })

-- splits
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })

--- tabs
vim.keymap.set("n", "<M-1>", ":tabn 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-2>", ":tabn 2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-3>", ":tabn 3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-4>", ":tabn 4<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-5>", ":tabn 5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-t>", ":tab split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-x>", ":tabclose<CR>", { noremap = true, silent = true })

-- visual mode stuff
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })


vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '',
			[vim.diagnostic.severity.INFO] = '',
		}
	},
	virtual_text = false,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.keymap.set("n", "<leader>tt", function()
	local themery = require("themery")
	local currentTheme = themery.getCurrentTheme()
	if currentTheme and currentTheme.name == "gruvbox light" then
		themery.setThemeByName("gruvbox dark", true)
	else
		themery.setThemeByName("gruvbox light", true)
	end
end, { noremap = true })
