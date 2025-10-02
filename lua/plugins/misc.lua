return {
	{ "kylechui/nvim-surround", event = "VeryLazy", config = true },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"preservim/nerdcommenter",
		keys = { { "<Leader><Leader>", "<Plug>NERDCommenterToggle", mode = { "n", "v" }, desc = "Toggle comment" } },
		event = "VeryLazy"
	},
}
