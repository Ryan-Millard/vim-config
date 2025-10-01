-- Transparent terminal colors
local groups = { "Normal", "NormalNC", "CursorLine", "LineNr" }
for _, g in ipairs(groups) do
	pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
end

-- Define the required highlight for indent-blankline scope
vim.api.nvim_set_hl(0, "IblScope", { fg = "#C678DD", bold = true })

return {
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
	{ "vim-airline/vim-airline" },
}
