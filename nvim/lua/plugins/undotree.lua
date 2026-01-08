return {
	"jiaoshijie/undotree",
	lazy = true,
	event = "BufEnter",
	dependencies = "nvim-lua/plenary.nvim",
	keys = { -- load the plugin only when using it's keybinding:
		-- { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	},
	config = function()
		require("undotree").setup({
			window = {
				winblend = 0,
			},
			position = "right",
		})
	end,
}
