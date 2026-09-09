vim.o.termguicolors = true
vim.loader.enable()
-- LAZY PLUGIN MANAGER
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Nothing here uses Python remote plugins (no pynvim installed). Skipping the
-- provider search saves ~275ms every time a Python file is opened.
vim.g.loaded_python3_provider = 0

require("vim-options")
require("lazy").setup("plugins")

-- EOF
