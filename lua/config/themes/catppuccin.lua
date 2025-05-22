local M = {}

function M.setup(opts)
    opts = opts or {}

    theme = require("catppuccin")
    theme.setup({
        flavour = opts.variant or "macchiato",
        transparent_background = opts.transparent or true,

        color_overrides = opts.color_overrides or {},
    })
    vim.cmd.colorscheme("catppuccin")
end

return M
