local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local config_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h:h")
package.path = package.path .. ";" .. config_path .. "/lua/?.lua;" .. config_path .. "/lua/?/init.lua"

require("core")

require("lazy").setup(require("plugins"))
