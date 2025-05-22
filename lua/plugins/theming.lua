return {
    { "maxmx03/FluoroMachine.nvim" },
    { "rose-pine/neovim" },
    { "scottmckendry/cyberdream.nvim", lazy = false,        priority = 1000, },
    { "liliwilson/warp-theme-nvim" },
    { "catppuccin/nvim",               name = "catppuccin", priority = 1000 },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = false,
        },
    },
    {
        "everviolet/nvim",
        name = "evergarden",
        priority = 1000,
        opts = {
            theme = {
                variant = 'winter',
                accent = 'green',
            },
            editor = {
                transparent_background = true,
                float = {
                    color = 'mantle',
                    invert_border = false,
                },
                completion = {
                    color = 'surface0',
                },
            },
        },
    },
    { "zootedb0t/citruszest.nvim" },
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            theme = {
                style = "dark",
                contrast = "default",
                transparent = true,
            },
            colors = {
                mode = "default",
                fluo = "pink",
                custom = {
                    saturation = "",
                    light = "",
                },
            },
            ui = {
                borders = "fluo",
                aggressive_spell = false,
            },
        },
    },
}
