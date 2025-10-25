return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePre" },
        config = function()
            local lint = require('lint')

            lint.linters_by_ft = {
                cmake = { 'cmakelint' },
                gitcommit = { 'commitlint' },
                c = { 'cpplint' },
                cpp = { 'cpplint' },
                go = { 'golangcilint' },
                dockerfile = { 'hadolint' },
                terraform = { 'tflint' },
                markdown = { 'vale' },
                latex = { 'vale' },
                yaml = { 'yamllint' },
                python = { 'ruff' },
            }

            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

            vim.api.nvim_create_autocmd( { 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
