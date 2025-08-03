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
        ft = { "nvimconf", },
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
                    "clangd",
                    "lua_ls",
                    "ruff",
                    "cmake",
                    "cmakelint",
                    "jsonls",
                    "dockerls",
                    "terraformls",
                    "yamlls",
                    "lemminx",
                    "rust_analyzer",
                    "glsl_analyzer",
                    "sqlls",
                    "gh_actions_ls",
                    "bashls",
                    "powershell_es",
                    "taplo",
                    "docker_compose_language_service",
                    "texlab",
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
