return {
	"folke/flash.nvim",
	event = "VeryLazy",
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					search = { forward = true, wrap = false, multi_window = false },
				})
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					search = { forward = false, wrap = false, multi_window = false },
				})
			end,
			desc = "Flash Back",
		},
	},
	---@type Flash.Config
	opts = {
		labels = "asdfghjklöwertzuioyxcvnm",
		search = {
			mode = "fuzzy",
			max_length = 2,
			exclude = {
				"notify",
				"cmp_menu",
				"noice",
				"flash_prompt",
				function(win)
					-- exclude non-focusable windows
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
		},
		jump = {
			history = true,
		},
		label = {
			exclude = "A",
			rainbow = {
				enabled = true,
				shade = 5,
			},
		},
		char = {
			char_actions = function(motion)
				return {
					[";"] = "prev", -- set to `right` to always go right
					[","] = "next", -- set to `left` to always go left
					-- clever- style
					[motion:lower()] = "prev",
					[motion:upper()] = "next",
					-- jump2d style: same case goes next, opposite case goes prev
					-- [motion] = "next",
					-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
				}
			end,
		},
	},
}
