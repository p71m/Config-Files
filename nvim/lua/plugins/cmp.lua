return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	lazy = false,
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "zbirenbaum/copilot-cmp" },
		{ "ray-x/cmp-treesitter" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "doxnit/cmp-luasnip-choice" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-buffer" }, -- adds too much items
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-emoji" },
		-- { "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-calc" },
		{ "FelipeLema/cmp-async-path" },
		{ "chrisgrieser/cmp_yanky" },
		{ "onsails/lspkind.nvim" },
		{ "chrisgrieser/cmp-nerdfont" },
		{ "dstein64/vim-startuptime", event = "VeryLazy" },
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("cmp_nvim_lsp").default_capabilities()
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Track if user actively closed completion
		local completion_manually_closed = false

		-- checks if there is a string infront of the cursor
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- configs
		cmp.setup({
			sources = {
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_document_symbol" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "treesitter" },
				{ name = "luasnip" },
				{ name = "cmp_luasnip" },
				{ name = "luasnip_choice" },
				{ name = "nvim_lua" },
				-- { name = "path" },
				{ name = "async_path" },
				{ name = "emoji" },
				{ name = "calc" },
				{ name = "cmp_yanky" },
				{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
				{ name = "nerdfont" },
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
					},
				},
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
			},

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						symbol_map = {
							Array = "",
							Boolean = "󰨙 ",
							Calendar = "",
							Comment = "",
							Copilot = " ",
							Null = "󰟢",
							Number = "",
							Object = "",
							Package = "",
							PackExpansion = " ",
							Recovery = " ",
							Reference = " ",
							Specifier = " ",
							Statement = "",
							String = "󰉿",
							Table = "",
							Template = "",
							TranslationUnit = " ",
							TypeParameter = " ",
							Watch = "󰥔",
							KeywordConditional = "󰌋",
							KeywordFunction = "󰌋",
						},
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = false })
					kind.kind = " " .. (strings[1] or " ") .. " "
					kind.menu = "    (" .. (strings[2] or " ") .. ")"
					return kind
				end,
			},
		})

		-- additional settings

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		-- ignore for certain Comannds
		cmp.setup.cmdline(":", {
			enabled = function()
				-- Set of commands where cmp will be disabled
				local disabled = {
					IncRename = true,
				}
				-- Get first word of cmdline
				local cmd = vim.fn.getcmdline():match("%S+")
				-- Return true if cmd isn't disabled
				-- else call/return cmp.close(), which returns false
				return not disabled[cmd] or cmp.close()
			end,
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- deacivates it in comments and Telescope prompts
		cmp.setup({
			enabled = function()
				local disabled = false
				disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
				disabled = disabled or (vim.fn.reg_recording() ~= "")
				disabled = disabled or (vim.fn.reg_executing() ~= "")
				-- disabled = disabled or require("cmp.config.context").in_treesitter_capture("comment")
				disabled = disabled or vim.bo.filetype == "copilot-chat"
				return not disabled
			end,
		})

		-- mappings
		cmp.setup({
			mapping = cmp.mapping({
				-- close cmp
				-- close cmp
				["<m-q>"] = cmp.mapping({
					i = function()
						completion_manually_closed = true
						cmp.abort()
					end,
					c = cmp.mapping.close(),
				}),
				-- scroll docs up/down
				["<m-j>"] = cmp.mapping.scroll_docs(4),
				["<m-k>"] = cmp.mapping.scroll_docs(-4),

				-- -- cycle through suggestions with m-j/m-k
				-- ["<m-j>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	elseif luasnip.locally_jumpable(1) then
				-- 		luasnip.jump(1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
				--
				-- ["<m-k>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	elseif luasnip.locally_jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),

				-- Enter: select if something is selected, otherwise newline
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				}),

				-- Tab: smart behavior based on context
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Reset manual close flag when completion is visible (user didn't close it)
					if cmp.visible() then
						completion_manually_closed = false
						-- If only one entry, confirm it immediately
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						else
							cmp.select_next_item()
						end
						-- If we can expand or jump in luasnip, do that
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
						-- If there are words before cursor, no completion visible, and wasn't manually closed
					elseif has_words_before() and not cmp.visible() and not completion_manually_closed then
						cmp.complete()
						-- If only one entry after triggering completion, confirm it immediately
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						end
						-- Otherwise, just insert a tab and reset manual close flag
					else
						completion_manually_closed = false
						fallback()
					end
				end, { "i", "s" }),

				-- Shift-Tab: reverse jump in luasnip or previous completion item
				["<S-Tab>"] = cmp.mapping(function(fallback)
					-- Reset manual close flag when completion is visible
					if cmp.visible() then
						completion_manually_closed = false
						cmp.select_prev_item()
						-- If we can jump backwards in luasnip, do that
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
