-- plugin for bufferline
return {
	"akinsho/bufferline.nvim",
	lazy = true,
	event = "BufEnter",
	version = "*",
	config = function()
		require("bufferline").setup({
			options = {
				indicator = {
					-- style = "underline",
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = function()
							return vim.fn.getcwd()
						end,
						highlight = "Directory",
						text_align = "left",
					},
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		})
	end,
}
