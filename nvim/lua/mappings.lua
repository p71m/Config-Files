-- Shorten function name
local map = vim.keymap.set

-- fold Method
-- refactor / rename / replace
-- jump blank line
-- trouble

-- ### Buffers ###
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "delete buffer" })
map("n", "<leader>bq", "<cmd>bd<cr>", { desc = "delete buffer" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "new buffer" })
map("n", "<leader>bS", "<cmd>w !sudo tee %<cr>", { desc = "save file as root" })

-- save file and use MiniTrailspace.trim()
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><cmd>lua MiniTrailspace.trim()<cr><esc>", {
	desc = "Save file",
})

-- ### LSP stuff ###
-- quickfix list
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "quickfix list" })

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })

-- format code
map({ "n", "v" }, "<leader>cF", function()
	vim.lsp.buf.format({ async = true })
end, {
	desc = "format file (lsp)",
})

-- Jump to the definition of the word under your cursor.
--  This is where a variable was first declared, or where a function is defined, etc.
--  To jump back, press <C-t>.
map("n", "<leader>dd", require("telescope.builtin").lsp_definitions, { desc = "goto definition" })

-- Find references for the word under your cursor.
map("n", "<leader>dr", require("telescope.builtin").lsp_references, { desc = "goto references" })

-- Jump to the implementation of the word under your cursor.
--  Useful when your language has ways of declaring types without an actual implementation.
map("n", "<leader>di", require("telescope.builtin").lsp_implementations, { desc = "goto implementation" })

-- Jump to the type of the word under your cursor.
--  Useful when you're not sure what type a variable is and you want to see
--  the definition of its *type*, not where it was *defined*.
map("n", "<leader>dt", require("telescope.builtin").lsp_type_definitions, { desc = "type definition" })

-- Fuzzy find all the symbols in your current document.
--  Symbols are things like variables, functions, types, etc.
map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "document symbols" })

-- Fuzzy find all the symbols in your current workspace.
--  Similar to document symbols, except searches over your entire project.
map("n", "dW", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Open Workspace Symbols" })

-- Execute a code action, usually your cursor needs to be on top of an error
-- or a suggestion from your LSP for this to activate.
map("n", "<leader>da", vim.lsp.buf.code_action, { desc = "code action" })

--  This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
map("n", "<leader>dD", vim.lsp.buf.declaration, { desc = "declaration" })

--- ### Movement ###
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- J move to next empty line
map({ "n", "v" }, "<m-j>", "}", { desc = "move to next empty line" })
map({ "n", "v" }, "<c-down>", "}", { desc = "move to next empty line" })
-- K move to previous empty line
map({ "n", "v" }, "<m-k>", "{", { desc = "move to previous empty line" })
map({ "n", "v" }, "<c-up>", "{", { desc = "move to previous empty line" })
-- E = end of line
-- map("n", "E", "$", { desc = "end of line" })
-- map("v", "E", "$", { desc = "end of line" })

-- ### Quit ###
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })
map("n", "<leader>qa", "<cmd>qa!<cr>", { desc = "quit all (forced)" })
map("n", "<leader>qb", "<cmd>bd<cr>", { desc = "quit buffer" })
map("n", "<leader>qw", "<C-W>c", { desc = "quit window" })

-- ### Text Manipulation ###
-- insert emtpty line with c-o and c-O
map("n", "<m-o>", "o<esc>", { desc = "insert empty line below" })
map("n", "<m-O>", "O<esc>", { desc = "insert empty line above" })
-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- select all
map("n", "<c-a>", "ggVG", { desc = "select all" })
-- escape to clear highlights
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear highlights" })

-- ### UI ###
-- Key mapping to toggle number modes
map("n", "<leader>un", ":lua ToggleNumberMode()<CR>", { desc = " number mode" })
-- toggle whitespace smbols
map("n", "<leader>uw", ":set list! <CR>", { desc = " whitespace symbols" })
-- telescoe cahnge colorscheme
map("n", "<leader>uc", ":lua ToggleColorMode()<CR>", { desc = " colorscheme Telescope" })
map("n", "<leader>uC", ":lua ToggleColorScheme()<CR>", { desc = " favorite colorscheme" })

-- toggle case
map("v", "<leader>cc", "~", { desc = "toggle case" })

-- ### cursor manipulation in insert mode ###
-- move cursor
map("i", "<m-h>", "<left>", { desc = "move cursor left" })
map("i", "<m-j>", "<down>", { desc = "move cursor down" })
map("i", "<m-k>", "<up>", { desc = "move cursor up" })
map("i", "<m-l>", "<right>", { desc = "move cursor right" })
-- delete word backwards/forward within insert mode
map("i", "<m-BS>", "<C-o>db", { desc = "delete word backwards" })
map("i", "<m-Del>", "<C-o>dw", { desc = "delete word forward" })
map("i", "<m-B>", "<C-o>db", { desc = "delete word backwards" })
map("i", "<m-E>", "<C-o>dw", { desc = "delete word forward" })
map("i", "<m-W>", "<C-o>dw", { desc = "delete word forward" })
-- beginning/end of word within insert mode
map("i", "<m-w>", "<esc>wwi", { desc = "move next forward" })
map("i", "<m-b>", "<esc>bi", { desc = "move word beginning" })
map("i", "<m-e>", "<esc>ea", { desc = "move word end" })
map("i", "<C-Left>", "<esc>bi", { desc = "move word backwards" })
map("i", "<C-Right>", "<esc>ea", { desc = "move word forwards" })

-- ### Window  ###
-- manipulating windows
map("n", "<leader>w", "<cmd>WhichKey <C-W><cr>", { desc = "window" })
map("n", "<leader>_", "<C-W>s", { desc = "split window vertically" })
map("n", "<leader>-", "<C-W>v", { desc = "split window horizontally" })
-- map("n", "<leader>w-", "<C-W>s", { desc = "split window vertically" })
-- map("n", "<leader>w_", "<C-W>v", { desc = "split window horizontally" })
-- map("n", "<leader>ww", "<C-W>p", { desc = "other window" })
-- map("n", "<leader>wd", "<C-W>c", { desc = "delete window" })
-- map("n", "<leader>wq", "<C-W>c", { desc = "delete window" })
-- move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<C-w>h", { desc = "go to left window" })
map("n", "<c-j>", "<C-w>j", { desc = "go to lower window" })
map("n", "<c-k>", "<C-w>k", { desc = "go to upper window" })
map("n", "<c-l>", "<C-w>l", { desc = "go to right window" })
-- Resize window using <ctrl> arrow keys
map("n", "<c-m-right>", "<cmd>vertical resize +2<cr>", { desc = "decrease window width" })
map("n", "<c-m-left>", "<cmd>vertical resize -2<cr>", { desc = "increase window width" })
map("n", "<c-m-down>", "<cmd>resize +2<cr>", { desc = "decrease window height" })
map("n", "<c-m-up>", "<cmd>resize -2<cr>", { desc = "increase window height" })

-- ### PLUGINS ###
-- lazy
map("n", "<leader>tL", "<cmd>Lazy<cr>", { desc = " Lazy" })

-- alpha
map("n", "<leader>ba", "<cmd>Alpha<cr>", { desc = "alpha" })

-- bufferline
-- -- close bufferline
map("n", "<m-x>", "<Cmd>bd<CR>", { desc = "close current buffer" })
-- Pin/unpin buffer
map("n", "<m-p>", "<Cmd>BufferLineTogglePin<CR>", { desc = "pin buffer" })
-- Magic buffer-picking mode
map("n", "<c-p>", "<Cmd>BufferLinePick<CR>", { desc = "pick buffer" })
-- Move to previous/next
map("n", "<m-,>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "previous buffer" })
map("n", "<m-.>", "<Cmd>BufferLineCycleNext<CR>", { desc = "next buffer" })
-- Re-order to previous/next
map("n", "<m-;>", "<Cmd>BufferLineMovePrev<CR>", { desc = "move buffer to previous" })
map("n", "<m-:>", "<Cmd>BufferLineMoveNext<CR>", { desc = "move buffer to next" })
-- Goto buffer in position...
map("n", "<m-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "goto buffer 1" })
map("n", "<m-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "goto buffer 2" })
map("n", "<m-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "goto buffer 3" })
map("n", "<m-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "goto buffer 4" })
map("n", "<m-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "goto buffer 5" })
map("n", "<m-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "goto buffer 6" })
map("n", "<m-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "goto buffer 7" })
map("n", "<m-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "goto buffer 8" })
map("n", "<m-8>", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "goto buffer 9" })
map("n", "<m-0>", "<Cmd>BufferLineGoToBuffer -1<CR>", { desc = "goto last buffer" })
-- Sort automatically by...
map("n", "<Space>bsd", "<Cmd>BufferLineSortByDirectory<CR>", { desc = "sort by buffer directory" })
map("n", "<Space>bse", "<Cmd>BufferLineSortByExtension<CR>", { desc = "sort by buffer extension" })
map("n", "<Space>bst", "<Cmd>BufferLineSortByTabs<CR>", { desc = "sort by window tabs" })

--- ### cmp ###
--- inside cmp file

-- copilot
map({ "n", "v" }, "<leader>tc", "<cmd>CopilotChatToggle<cr>", { desc = "toggle CopilotChat" })
map("n", "<leader>ccm", "<cmd>CopilotChatModel<cr>", { desc = "CopilotChat Model" })
map("n", "<leader>ccp", "<cmd>CopilotChatPromts<cr>", { desc = "CopilotChat Promts" })
map("n", "<leader>ccm", "<cmd>CopilotChatModel<cr>", { desc = "CopilotChat Model" })
map("n", "<leader>ccs", function()
	local name = vim.fn.input("Save chat as (empty for default): ")
	require("CopilotChat").save(name ~= "" and name or nil)
	vim.notify("Chat Saved" .. (name ~= "" and " as '" .. name .. "'" or ""), vim.log.levels.INFO)
end, { desc = "CopilotChat Save" })
map("n", "<leader>ccl", function()
	local name = vim.fn.input("Load chat (empty for default): ")
	require("CopilotChat").load(name ~= "" and name or nil)
	vim.notify("Chat Loaded" .. (name ~= "" and " '" .. name .. "'" or ""), vim.log.levels.INFO)
end, { desc = "CopilotChat Load" })
map("n", "<leader>ccc", "<cmd>CopilotChatStop<cr>", { desc = "CopilotChat Stop" })

-- Quick chat keybinding
map("n", "<leader>ccq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, {
			selection = require("CopilotChat.select").buffer,
		})
	end
end, { desc = "copilotChat - Quick chat" })

-- conform
-- map("n", "<leader>cf", function()
-- 	require("conform").format({ async = true, lsp_fallback = true })
-- end, { desc = "format file (conform)" })
map({ "n", "x" }, "<leader>cf", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })

-- markdown preview
map("n", "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>", { desc = " MarkdownPreview" })

-- mini
-- move lines with mini.move
require("mini.move").setup({
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-H>",
		right = "<M-L>",
		down = "<M-J>",
		up = "<M-K>",
		-- Move current line in Normal mode
		line_left = "<M-H>",
		line_right = "<M-L>",
		line_down = "<M-J>",
		line_up = "<M-K>",
	},
})

-- neo tree
map("n", "<leader>e", "<cmd>Neotree focus right<cr>", { desc = "NeoTree" })
-- map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = " neo tree" })

-- noice
map("n", "<leader>tM", "<cmd>Noice<cr>", { desc = " messages" })

-- oil
map("n", "<leader>o", function()
	require("oil").toggle_float()
end, { desc = " Oil" })
map("n", "<leader>to", function()
	require("oil").toggle_float()
end, { desc = " toggle Oil" })

-- persistence
-- restore the session for the current directory
map("n", "<leader>br", [[<cmd>lua require("persistence").load()<cr>]], { desc = "restore session from cwd" })
-- restore the last session
map("n", "<leader>bl", [[<cmd>lua require("persistence").load({ last = true })<cr>]], { desc = "restore last session" })

-- telescope
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = " help" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = " keymaps" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = " files cwed" })
map("n", "<leader>fF", "<cmd>Telescope find_files search_dirs=~<cr>", { desc = " files root" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = " old files" })
map("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", { desc = " string in cwd" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = " buffers" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = " diagnostics" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = " current string in cwd" })
map("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = " git status" })
map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = " projects" })
map("n", "<leader>tl", "<cmd>ToggleLSP<cr>", { desc = " LSPs" })
map("n", "<leader>tn", "<cmd>Telescope neoclip<cr>", { desc = " clipboard" })
-- map({"n", "v"}, ":", "<cmd>Telescope cmdline<cr>", { desc = " Telescope cmdline" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "fuzzy search in current buffer" })
map("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "find buffers" })

-- undotree
map("n", "<leader>tu", "<cmd>lua require('undotree').toggle()<cr>", {
	desc = " undotree",
})
-- zen mode
map("n", "<leader>tz", "<cmd>ZenMode<cr>", { desc = " zen mode" })
