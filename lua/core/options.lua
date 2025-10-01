vim.g.mapleader = "\\"

local o = vim.opt
o.mouse = ""
o.backspace = "indent,eol,start"
o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.smartindent = true
o.listchars = {
	tab = "▎ ",     -- vertical bar for tabs
	trail = "·",    -- dot for trailing spaces
	extends = "›",  -- when line continues
	precedes = "‹", -- when line continues backwards
	nbsp = "␣",     -- non-breaking space
}
o.syntax = "enable"
o.list = true
o.cursorline = true
o.incsearch = true
o.showmatch = true
o.ruler = true
o.statusline = "%F %p%% %l:%c %L"
o.wrap = false
o.filetype = "plugin"
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
