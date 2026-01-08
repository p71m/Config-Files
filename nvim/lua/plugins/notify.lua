return {
	"rcarriga/nvim-notify",
    config = function ()
        require("notify").setup({
            timeout = 2000,
            -- render = "wrapped-compact",
            stages = "static",
        })
    end
}
