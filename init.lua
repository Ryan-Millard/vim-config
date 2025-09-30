-- =======================================================
-- Leader key
-- =======================================================
vim.g.mapleader = "\\"

-- =======================================================
-- Basic options
-- =======================================================
local o = vim.opt
o.backspace = "indent,eol,start"
o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.smartindent = true
o.syntax = "enable"
o.list = true
o.listchars = { tab = "▸ ", trail = "·" }
o.cursorline = true
o.incsearch = true
o.showmatch = true
o.ruler = true
o.statusline = "%F %p%% %l:%c %L"
o.wrap = false
o.filetype = "plugin"

-- Silent Vim
o.errorbells = false
o.visualbell = false
o.belloff = "all"

-- WSL2 clipboard integration
vim.g.clipboard = {
	name = "win32yank-wsl",
	copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
	paste = { ["+"] = "powershell.exe -c Get-Clipboard", ["*"] = "powershell.exe -c Get-Clipboard" },
	cache_enabled = 0,
}

-- =======================================================
-- Keymaps
-- =======================================================
local map = vim.keymap.set

-- Copy entire file to Windows clipboard
map("n", "<Leader>ya", [[:%w !clip.exe<CR>:redraw!<CR>]], { silent = true })

-- NerdCommenter toggle
map({"n", "v"}, "<Leader><Leader>", "<Plug>NERDCommenterToggle")

-- NERDTree
map("n", "<Leader>d", ":NERDTreeToggle<CR>")
map("n", "<Leader>ex", ":tabe | NERDTree | only<CR>")

-- Tagbar
map("n", "<Leader>t", ":TagbarToggle<CR>")

-- Emmet (trigger manually via Ctrl-e in insert mode)
map("i", "<C-e>", '<C-o>:call emmet#expandAbbr(0,"i")<CR>')

-- =======================================================
-- Plugins using lazy.nvim
-- =======================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- NERDTree
	{ "preservim/nerdtree", cmd = "NERDTreeToggle" },

	-- vim-airline
	{ "vim-airline/vim-airline" },

	-- Emmet
	{ "mattn/emmet-vim", event = "InsertEnter" },

	-- NerdCommenter
	{ "preservim/nerdcommenter" },

	-- Tagbar
	{ "preservim/tagbar", cmd = "TagbarToggle" },

	-- Vim Surround
	{ "tpope/vim-surround" },

	-- Kotlin syntax
	{ "udalov/kotlin-vim" },

	-- .editorconfig
	{ "editorconfig/editorconfig-vim" },
})

-- =======================================================
-- Transparent terminal colors
-- =======================================================

-- Clear highlights for key groups to force terminal defaults
local groups = {
  "Normal", "NormalNC", "SignColumn", "CursorLine", "LineNr",
  "FoldColumn", "VertSplit", "StatusLine", "StatusLineNC",
  "TabLine", "TabLineFill", "TabLineSel", "Pmenu", "PmenuSel",
  "PmenuSbar", "PmenuThumb", "NormalFloat"
}

local function use_terminal_colors()
  for _, g in ipairs(groups) do
    -- Only set bg=nil to make it transparent; fg=nil keeps terminal default
    pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
  end
end

-- Apply immediately
use_terminal_colors()
