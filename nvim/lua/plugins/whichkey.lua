return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>b", group = " buffer" },
				{ "<leader>c", desc = " code" },
				{ "<leader>bs", desc = " sort" },
				{ "<leader>d", desc = " diagnostics" },
				-- { "<leader>f", group = "file", desc = "file" },
				-- { "<leader>g",  desc = "git"},
				-- { "<leader>h", desc = " help" },
				-- { "<leader>l",  desc = "lsp"},
				{ "<leader>q", desc = "quit" },
				{ "<leader>cs", desc = "surround" },
				{ "<leader>cc", desc = "copilot" },
                -- { "<leader>s", group = "search"},
				{ "<leader>t", desc = "toggle" },
				{ "<leader>u", desc = "ui" },
				{ "<leader>w", desc = "window" },
			},
		},
	},
}
