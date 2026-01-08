return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Optional dependencies
	opts = {
		columns = {
			"mtime",
			"size",
			-- "permissions",
			"icon",
		},
		keymaps = {
			["q"] = { "actions.close", mode = "n" },
		},
		view_options = {
			show_hidden = true,
		},

		float = {
			-- Padding around the floating window
			padding = 2,
			-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			max_width = 0.9,
			max_height =0.9,
			border = "rounded",
			-- preview_split: Split direction: "auto", "left", "right", "above", "below".
			preview_split = "auto",
		},
		preview_win = {
			update_on_cursor_moved = true,
			preview_method = "fast_scratch",
		},
	},
}
