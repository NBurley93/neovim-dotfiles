local M = {}

function M.setup(opts)
    opts = opts or {}
    local variant = opts.variant or "wave"
    require("kanagawa").load(variant)
end

return M
