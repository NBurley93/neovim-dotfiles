local M = {}

function M.setup(opts)
    opts = opts or {}

    theme = require("evergarden")
    vim.cmd.colorscheme("evergarden")
end

return M
