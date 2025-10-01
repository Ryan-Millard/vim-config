-- =======================================================
-- Leader key
-- =======================================================
vim.g.mapleader = "\\"

-- =======================================================
-- Basic options
-- =======================================================
local o = vim.opt
--o.mouse = ""
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

-- NvimTree
map("n", "<Leader>d", ":NvimTreeToggle<CR>")
map("n", "<Leader>ex", ":tabe | NvimTree | only<CR>")

-- Tagbar
map("n", "<Leader>t", ":TagbarToggle<CR>")

-- Emmet (trigger manually via Ctrl-e in insert mode)
map("i", "<C-e>", '<C-o>:call emmet#expandAbbr(0,"i")<CR>')

-- Telescope
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live grep" })
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Find buffers" })
map("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help tags" })

-- Inspect under cursor
vim.api.nvim_set_keymap(
	"n",
	"<leader>i",
	":TSHighlightCapturesUnderCursor<CR>",
	{ noremap = true, silent = true }
)

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
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				git = {
					enable = true,        -- enable git coloring
					ignore = false,       -- don't hide ignored files
					timeout = 400,
				},
				renderer = {
					highlight_git = true,  -- color filenames by git status
					icons = {
						show = { git = true }, -- hide git glyphs
					}
				},
			})
		end,
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
	},

	-- Telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		config = function()
			local telescope = require('telescope')
			local builtin = require('telescope.builtin')

			telescope.setup{
				defaults = {
					hidden = true,
					no_ignore = false,
					file_ignore_patterns = { 
						"%.git/",          -- ignore .git folder
						"node_modules/",   -- ignore node_modules
						"dist/",           -- ignore build/output folders
					},
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = {"smart"},
				},
				pickers = {
					find_files = { hidden = true, no_ignore = true },
					live_grep = {
						additional_args = function(opts)
							return {"--hidden"}
						end,
					},
				}
			}

			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
			vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
			vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
			vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').find_files({hidden=true, no_ignore=true})<CR>", opts)
		end
	},

	-- LSP configuration
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
	},

	-- Treesitter (syntax highlighting & parsing)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = { "lua", "kotlin", "python", "javascript", "html", "css" },
			})
		end,
	},
	{
		"nvim-treesitter/playground",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				playground = {
					enable = true,
					updatetime = 25,
					persist_queries = false,
				},
			})
		end,
	},

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				-- REMOVE gutter signs completely
				signs = {
					add          = { text = "" },
					change       = { text = "" },
					delete       = { text = "" },
					topdelete    = { text = "" },
					changedelete = { text = "" },
				},
				numhl = true,  -- use line-number background
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = function(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", gs.next_hunk)
					map("n", "[c", gs.prev_hunk)

					-- Actions
					map("n", "<Leader>hs", gs.stage_hunk)
					map("n", "<Leader>hr", gs.reset_hunk)
					map("n", "<Leader>hp", gs.preview_hunk)
					map("n", "<Leader>hb", gs.blame_line)
					map("n", "<Leader>hu", gs.undo_stage_hunk)
				end,
			})

			-- Full line-number backgrounds
			vim.api.nvim_set_hl(0, "GitSignsAddNr",    { bg = "#1fbf5f", fg = "#ffffff", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsChangeNr", { bg = "#ffb000", fg = "#000000", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { bg = "#ff1f1f", fg = "#ffffff", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { bg = "#ff1f1f", fg = "#ffffff", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { bg = "#ff5555", fg = "#ffffff", bold = true })
		end,
	},
	{ "tpope/vim-fugitive" },

	-- Modern surround
	{ "kylechui/nvim-surround", event = "VeryLazy", config = true },

	-- Repeat (for dot command with plugins)
	{ "tpope/vim-repeat" },

	-- Indentation guides with scope and colors
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = true, show_start = true, show_end = true },
			indent = { highlight = { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan" } },
		},
		config = function(_, opts)
			-- rainbow highlight groups
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			require("ibl").setup(opts)
		end,
	},

	-- Airline (optional, keep since you had it)
	{ "vim-airline/vim-airline" },

	-- Emmet
	{ "mattn/emmet-vim", event = "InsertEnter" },

	-- NerdCommenter (you may want to swap to Comment.nvim later)
	{ "preservim/nerdcommenter" },

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
	"Normal",       -- text in buffer
	"NormalNC",     -- non-current buffer
	"CursorLine",   -- current line highlight (optional)
	"LineNr",       -- line numbers (optional)
}

local function use_terminal_colors()
	for _, g in ipairs(groups) do
		--Only set bg=nil to make it transparent; fg=nil keeps terminal default
		pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
	end
end

-- Apply immediately
use_terminal_colors()
