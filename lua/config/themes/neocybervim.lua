local M = {}

function M.setup(opts)
    opts = opts or {}

    require("NeoCyberVim").setup({
        transparent = true,
        italics = {
            comments = true,
            keywords = true,
            functions = true,
            strings = true,
            variables = true,
        },
        overrides = {},
    })
    vim.cmd.colorscheme('NeoCyberVim')
end

return M
