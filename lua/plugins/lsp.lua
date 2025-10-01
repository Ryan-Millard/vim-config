return {
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim" },
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
}
