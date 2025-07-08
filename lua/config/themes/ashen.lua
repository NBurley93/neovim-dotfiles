local M = {}

function M.setup(opts)
    opts = opts or {}

    theme = require("ashen")
    theme.load()
end

return M
