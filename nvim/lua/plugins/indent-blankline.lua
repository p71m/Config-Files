-- lines under function and whitespaces
return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = true,
	event = "BufEnter",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = "▏",
			},
            -- The scope is not the current indentation level! Instead, it is the indentation level where variables or functions are accessible
			scope = {
				show_start = false,
			},
			whitespace = {},
		})
	end,
}
