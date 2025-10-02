-- Transparent terminal colors
local groups = { "Normal", "NormalNC", "CursorLine", "LineNr" }
for _, g in ipairs(groups) do
	pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require('lualine').setup({ options = { theme = 'auto' } })
		end
	},
}
