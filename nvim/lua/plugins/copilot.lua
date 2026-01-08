return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false, -- Change to false to ensure it loads properly
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				-- Disable native suggestions since we're using cmp integration
				suggestion = {
					enabled = false,
				},
				panel = {
					enabled = false,
				},
			})
		end,
	},

	-- copilot chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "claude-sonnet-4",
			sticky = {
				"#buffers",
			},
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
				width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
			},
			selection = function(source)
				local select = require("CopilotChat.select")
				return select.visual(source)
			end,
			question_header = " User ",
			answer_header = " Copilot ",
			error_header = " Error ",
			log_level = "warn",
		},
	},
}
