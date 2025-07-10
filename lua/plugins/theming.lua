return {
    { "maxmx03/FluoroMachine.nvim" },
    { "DonJulve/NeoCyberVim"},
    { "rose-pine/neovim" },
    {
        "ficcdaf/ashen.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style_presets = {
                bold_functions = true,
                italic_comments = true,
            },
            colors = {
                background = "none" -- Transparent background
            },
        },
    },
    { "scottmckendry/cyberdream.nvim", lazy = false,        priority = 1000, },
    { "liliwilson/warp-theme-nvim" },
    {
        "devoc09/lflops.nvim",
        priority = 1000,
        opts = {
            transparent_mode = true,
        },
    },
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
