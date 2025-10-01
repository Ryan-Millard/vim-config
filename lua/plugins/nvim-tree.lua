return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
	keys = {
		{ "<Leader>d",  "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ "<Leader>ex", "<cmd>tabe | NvimTree | only<CR>", desc = "Explorer tab" },
	},
	config = function()
		require("nvim-tree").setup({
			git = { enable = true, ignore = false, timeout = 400 },
			renderer = {
				highlight_git = true,
				icons = { show = { git = true } },
			},
		})
	end,
}
