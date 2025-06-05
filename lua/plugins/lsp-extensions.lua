return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            { "jay-babu/mason-null-ls.nvim", lazy = true },
        },
    },
    {
        "folke/lazydev.nvim",
        event = {
            "BufReadPost *.lua",
            "BufNewFile *.lua",
        },
        ft = "lua",
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "yamlls",
                    "rust_analyzer",
                    "terraformls",
                    "dockerls",
                    "jsonls",
                    "cmake",
                    "ruff",
                    "clangd",
                },
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            progress = {
                display = {
                    done_icon = "✅",
                    progress_icon = {
                        pattern = "circle_quarters",
                        period = 1,
                    },
                },
            },
            notification = {
                window = {
                    winblend = 0,
                    relative = "editor",
                    x_padding = 2,
                    y_padding = 1,
                },
            },
        },
    },
    { "p00f/clangd_extensions.nvim", ft = { "c", "cpp", "rust" }, event = { "BufReadPost", "BufNewFile" }, },
}
