return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                yaml = { "yamlfmt" },
                dockerfile = { "hadolint" },
                gitcommit = { "commitlint" },
                terraform = { "terraform_fmt" },
                cmake = { "cmake_format" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        },
    },
}
