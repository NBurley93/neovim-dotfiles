local M = {}

function M.setup(opts)
    opts = opts or {}

    theme = require("catppuccin")
    theme.setup({
        flavour = opts.variant or "macchiato",
    })
    vim.cmd.colorscheme("catppuccin")
end

return M
