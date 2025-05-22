local M = {}

function M.setup(opts)
    opts = opts or {}

    theme = require("flow")
    vim.cmd.colorscheme("flow")
end

return M
