return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "jvgrootveld/telescope-zoxide" },
		{ "tsakirist/telescope-lazy.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "jonarrien/telescope-cmdline.nvim" },
		{
			"adoyle-h/lsp-toggle.nvim",
			config = function()
				require("lsp-toggle").setup({
					create_cmds = true, -- Whether to create user commands
					telescope = true, -- Whether to load telescope extensions
				})
			end,
		},
		{
			"AckslD/nvim-neoclip.lua",
			dependencies = {
				{ "kkharji/sqlite.lua", module = "sqlite" },
			},
			config = function()
				require("neoclip").setup()
			end,
		},
	},

	config = function()
		require("telescope").setup({
			theme = "tokyonight",
			defaults = {
				prompt_prefix = "   ",
				--initial_mode = "insert"
				selection_strategy = "reset",
				-- sorting_strategy = "ascending",
				sorting_strategy = "descending",
				layout_strategy = "horizontal",
				mappings = {
					n = {
						["q"] = require("telescope.actions").close,
						["<esc>"] = require("telescope.actions").close,
					},
					i = {
						-- ["<esc>"] = require("telescope.actions").close,
						["<M-j>"] = require("telescope.actions").move_selection_next,
						["<M-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
				preview = {
					mime_hook = function(filepath, bufnr, opts)
						local is_image = function(filepath)
							local image_extensions = { "png", "jpg" } -- Supported image formats
							local split_path = vim.split(filepath:lower(), ".", { plain = true })
							local extension = split_path[#split_path]
							return vim.tbl_contains(image_extensions, extension)
						end
						if is_image(filepath) then
							local term = vim.api.nvim_open_term(bufnr, {})
							local function send_output(_, data, _)
								for _, d in ipairs(data) do
									vim.api.nvim_chan_send(term, d .. "\r\n")
								end
							end
							vim.fn.jobstart({
								"chafa",
								filepath, -- Terminal image viewer command
							}, { on_stdout = send_output, stdout_buffered = true, pty = true })
						else
							require("telescope.previewers.utils").set_preview_message(
								bufnr,
								opts.winid,
								"Binary cannot be previewed"
							)
						end
					end,
				},
			},
			pickers = {
				find_files = {
					-- theme = "cursor",
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				oldfiles = {
					-- initial_mode = "normal",
				},
				buffers = {
					-- initial_mode = "normal",
				},
				media_files = {
					-- theme = "cursor",
					-- initial_mode = "normal",
				},
				project = {
					-- initial_mode = "normal",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("zoxide")
		require("telescope").load_extension("lazy")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("project")
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("cmdline")
		require("telescope").load_extension("notify")
        require("telescope").load_extension("fidget")
		-- require("telescope").load_extension("lsp-toggle")

		-- local actions = require("telescope.actions")
		-- local open_with_trouble = require("trouble.sources.telescope").open
		--
		-- -- Use this to add more results without clearing the trouble list
		-- local add_to_trouble = require("trouble.sources.telescope").add
		--
		-- local telescope = require("telescope")
		--
		-- telescope.setup({
		--     defaults = {
		--         mappings = {
		--             i = { ["<c-t>"] = open_with_trouble },
		--             n = { ["<c-t>"] = open_with_trouble },
		--         },
		--     },
		-- })
	end,
}
