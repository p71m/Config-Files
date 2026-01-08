return {
    "codethread/qmk.nvim",
    config = function()
        require("qmk").setup({
            name = "sofle",
            variant = "zmk",
            layout = {
                '_ _ _ _ x x x x x x _ _ _ x x x x x x',
                '_ _ _ _ x x x x x x _ _ _ x x x x x x',
                '_ _ _ _ x x x x x x _ _ _ x x x x x x',
                '_ _ _ _ x x x x x x x _ x x x x x x x',
                '_ _ _ _ _ _ x x x x x _ x x x x x _ _',
            },
            comment_preview = {
                position = 'none',
                keymap_overrides = {
                    MAGIC_SHIFT = "MAGIC_SHIFT",
                },
            },
        })
    end,
}
