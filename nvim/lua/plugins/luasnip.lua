return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	history = true,
	delete_check_events = "TextChanged",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
