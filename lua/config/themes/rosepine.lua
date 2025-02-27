local M = {}

function M.setup(opts)
    opts = opts or {}

    rosepine = require("rose-pine")
    rosepine.setup({
        variant = opts.variant or "moon",
        styles = {
            transparency = true,
        },
    })
    vim.cmd.colorscheme("rose-pine")
end

return M
