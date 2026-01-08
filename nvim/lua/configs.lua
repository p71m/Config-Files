-- vim.opt.spell = true
-- vim.opt.spelllang = { "en", "de_DE" }

-- use nerd font if available
vim.g.have_nerd_font = false

-- Set initial color scheme
vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("gruvbox-material")

-- function to toggle between favoutite colorschemes
function ToggleColorScheme()
	if vim.g.colors_name == "tokyonight-night" then
		vim.cmd.colorscheme("gruvbox-material")
	else
		vim.cmd.colorscheme("tokyonight-night")
	end
end

function ToggleColorMode()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

-- Enable absolute line numbers for the current line and relative line numbers for other lines.
vim.wo.number = true
vim.wo.relativenumber = true

-- Function to toggle line number modes
function ToggleNumberMode()
	if vim.wo.number and vim.wo.relativenumber then
		vim.wo.relativenumber = false
	elseif vim.wo.number and not vim.wo.relativenumber then
		vim.wo.number = false
		vim.wo.relativenumber = false
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
	end
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
        vim.hl.on_yank()
	end,
})

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Disable line wrapping. Lines will not wrap around when they exceed the screen width
vim.opt.wrap = true

-- splits on the right
vim.opt.splitright = true

-- Columns of context
vim.opt.sidescrolloff = 8

-- whitespace symbols
vim.opt.listchars = {
	eol = "¬",
	space = "·",
	trail = "·",
	tab = "▸ ",
	extends = "⇢",
	precedes = "⇠",
	nbsp = "×",
}

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- folding for ufo etc
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Do not display the mode (e.g., -- INSERT --) since it's shown in the status line.
vim.opt.showmode = false

-- Hide the status line completely. This can make the interface cleaner but removes the status information.
vim.opt.laststatus = 0

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Enable highlighting of the current line
vim.opt.cursorline = true

-- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

-- Insert indents automatically
vim.opt.smartindent = true

-- True color support
vim.opt.termguicolors = true

-- Enable mouse support
vim.opt.mousemoveevent = true

-- vim.opt.timeoutlen = 200

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Decrease update time
vim.opt.updatetime = 250

vim.opt.undofile = true

vim.opt.undolevels = 1000

vim.opt.conceallevel = 2

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.opt.clipboard = "unnamedplus"
-- end)
-- sync with system clipboard on focus gained windows
-- vim.api.nvim_create_autocmd({ "FocusGained" }, {
-- 	pattern = { "*" },
-- 	command = [[call setreg("@", getreg("+"))]],
-- })
-- -- sync with system clipboard on focus lost
-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
-- 	pattern = { "*" },
-- 	command = [[call setreg("+", getreg("@"))]],
-- })
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

-- make sure that neotree is being closed properly so it doesnt interfere with autosession plugin
vim.api.nvim_create_autocmd("VimLeavePre", {
	command = ":Neotree close",
})
