return {

	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		keys = function()
			local gs = require("gitsigns")
			return {
				{ "]c", gs.next_hunk, desc = "Next hunk" },
				{ "[c", gs.prev_hunk, desc = "Prev hunk" },
				{ "<Leader>hs", gs.stage_hunk, desc = "Stage hunk" },
				{ "<Leader>hr", gs.reset_hunk, desc = "Reset hunk" },
				{ "<Leader>hp", gs.preview_hunk, desc = "Preview hunk" },
				{ "<Leader>hb", gs.blame_line, desc = "Blame line" },
				{ "<Leader>hu", gs.undo_stage_hunk, desc = "Undo stage hunk" },
			}
		end,
		config = function()
			require("gitsigns").setup({
				signs = { add = { text = "" }, change = { text = "" }, delete = { text = "" }, topdelete = { text = "" }, changedelete = { text = "" } },
				numhl = true,
			})
			vim.api.nvim_set_hl(0, "GitSignsAddNr",    { bg = "#1fbf5f", fg = "#ffffff", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsChangeNr", { bg = "#ffb000", fg = "#000000", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { bg = "#ff1f1f", fg = "#ffffff", bold = true })
		end,
	},
	{ "tpope/vim-fugitive", cmd = "Git" },
}
