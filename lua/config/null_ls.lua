local unwrap_groups = function(groups)
    local sources = {}

    for _, group in ipairs(groups) do
        for _, module in ipairs(group) do
            table.insert(sources, module)
        end
    end

    return sources
end

return {
    config = function()
        local null_ls = require("null-ls")

        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        null_ls.setup({
            sources = unwrap_groups({
                terraform = {
                    diagnostics.terraform_validate,
                    formatting.terraform_fmt,
                },
                lua = {
                    formatting.stylua,
                },
                nvimconf = {
                    formatting.stylua,
                },
                cmake = {
                    diagnostics.cmake_lint,
                },
                go = {
                    diagnostics.golangci_lint,
                },
                yaml = {
                    formatting.yamlfmt,
                    diagnostics.yamllint,
                },
                docker = {
                    diagnostics.hadolint,
                },
                gitcommit = {
                    diagnostics.commitlint,
                },
                latex = {
                    diagnostics.vale,
                },
            }),
        })
    end,
}
