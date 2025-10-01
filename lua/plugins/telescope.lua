return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim", -- added undo extension
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Find buffers" },
		{ "<leader>fh", function() require("telescope.builtin").find_files{ hidden = true, no_ignore = true } end, desc = "Find all files" },
		{ "<leader>fu", function() require("telescope").extensions.undo.undo() end, desc = "Telescope undo" }, -- new undo keymap
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				hidden = true,
				file_ignore_patterns = { "%.git/", "node_modules/", "dist/" },
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				path_display = { "smart" },
			},
			pickers = {
				find_files = { hidden = true, no_ignore = true },
				live_grep = { additional_args = function() return { "--hidden" } end },
			},
		})

		-- Load the undo extension
		telescope.load_extension("undo")
	end,
}
