vim.o.termguicolors = true

return {

	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		keys = function()
			local gs = require("gitsigns")

			local function git_floating(cmd)
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.6)
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)

				-- Create empty buffer
				local buf = vim.api.nvim_create_buf(false, true)

				-- Floating terminal window
				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					row = row,
					col = col,
					width = width,
					height = height,
					style = "minimal",
					border = "rounded",
				})

				-- Transparent highlights
				vim.api.nvim_set_hl(0, "MyFloat", { bg = "NONE", fg = "NONE" })
				vim.api.nvim_set_hl(0, "MyFloatBorder", { bg = "NONE", fg = "#888888" })
				vim.api.nvim_win_set_option(win, "winhl", "Normal:MyFloat,FloatBorder:MyFloatBorder")

				-- Open terminal in the buffer
				local term_job = vim.fn.termopen("git " .. cmd)

				-- Close mappings
				local close_win = function()
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_close(win, true)
					end
				end
				vim.keymap.set("n", "<CR>", close_win, { buffer = buf, silent = true })
				vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, silent = true })

				return term_job
			end


			return {
				{ "]c", gs.next_hunk, desc = "Next hunk" },
				{ "[c", gs.prev_hunk, desc = "Prev hunk" },
				{ "<Leader>hs", gs.stage_hunk, desc = "Stage hunk" },
				{ "<Leader>hr", gs.reset_hunk, desc = "Reset hunk" },
				{ "<Leader>hp", gs.preview_hunk, desc = "Preview hunk" },
				{ "<Leader>hb", gs.blame_line, desc = "Blame line" },
				{ "<Leader>hu", gs.undo_stage_hunk, desc = "Undo stage hunk" },

				-- fugitive keys with ephemeral output
				{ "<Leader>gs", function() git_floating("status") end, desc = "Git status" },
				{
					"<Leader>gl",
					function()
						local count = vim.v.count1
						git_floating("log --oneline -n " .. count)
					end,
					desc = "Git log"
				},
				{ "<Leader>gd", function() git_floating("diff --color") end, desc = "Git diff current file" },
				{ "<Leader>gb", function() git_floating("blame -c " .. vim.fn.expand("%")) end, desc = "Blame current file" },
				-- commands that need a buffer
				{ "<Leader>gc", ":Git commit<CR>", desc = "Git commit" },
				{ "<Leader>gaa", ":Git add -a<CR>", desc = "Git add -a" },
				{ "<Leader>gaA", ":Git add -A<CR>", desc = "Git add -A" },
				{ "<Leader>gC", ":Git commit --amend<CR>", desc = "Amend last commit" },
				{ "<Leader>gb", ":Git blame<CR>", desc = "Full blame buffer" },
				{ "<Leader>gD", ":Gdiffsplit<CR>", desc = "Git diff in split" },
				{ "<Leader>gco", ":Git checkout ", desc = "Git checkout branch" },
				{ "<Leader>gbn", ":Git branch<CR>", desc = "List branches" },
				{ "<Leader>gL", ":Git log -- %<CR>", desc = "Git log for file" },
				{ "<Leader>gp", ":Git push<CR>", desc = "Git push" },
				{ "<Leader>gP", ":Git pull<CR>", desc = "Git pull" },
			}
		end,
		config = function()
			require("gitsigns").setup({
				signs = { add = { text = "" }, change = { text = "" }, delete = { text = "" }, topdelete = { text = "" }, changedelete = { text = "" } },
				numhl = true,
			})

			vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#000000", bg = "#00ff00", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#000000", bg = "#ffaa00", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#000000", bg = "#ff0000", bold = true })

			vim.api.nvim_set_hl(0, "GitSignsAddNr",    { fg = "#000000", bg = "#00ff00", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#000000", bg = "#ffaa00", bold = true })
			vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#000000", bg = "#ff0000", bold = true })
		end,
	},
	{ "tpope/vim-fugitive", cmd = "Git" },
}
