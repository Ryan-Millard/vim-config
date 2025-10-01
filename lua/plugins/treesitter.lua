return {

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
		keys = { { "<Leader>i", ":TSHighlightCapturesUnderCursor<CR>", desc = "Inspect highlight group" } },
		config = function()
			require("nvim-treesitter.configs").setup({
				playground = { enable = true, updatetime = 25, persist_queries = false },
			})
		end,
	},
}
