return {
	"gbprod/yanky.nvim",
	dependencies = {
		{ "kkharji/sqlite.lua" },
	},
	opts = {
		ring = { storage = "sqlite" },
	},
	keys = {
		{
			"<leader>p",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
			desc = "Open Yank History",
		},
	},
}
