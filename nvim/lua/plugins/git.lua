return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
			})

			-- Set custom highlight colors
			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4ade80" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#3b82f6" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f87171" })
			vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#a78bfa" })
		end,
	},
	{
		"sindrets/diffview.nvim",
	},
}
