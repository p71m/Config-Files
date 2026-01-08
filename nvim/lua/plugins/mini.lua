return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.comment").setup({})
		require("mini.move").setup({})
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.fuzzy").setup({})
		require("mini.trailspace").setup({})
	end,
}

