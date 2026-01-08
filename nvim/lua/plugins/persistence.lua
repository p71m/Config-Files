return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("config") .. "/.sessions/"), -- directory where session files are saved
		options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
	},
}
