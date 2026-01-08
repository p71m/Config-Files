return {
	"nvim-lualine/lualine.nvim",
	requires = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = "",
				component_separators = "",
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 3,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
					},
					"filetype",
					"encoding",
					"fileformat",
				},
				lualine_y = { "progress", "location" },
				lualine_z = {
					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
