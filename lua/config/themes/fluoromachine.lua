local M = {}

function M.setup(opts)
    opts = opts or {}

    local fm = require("fluoromachine")
    fm.setup({
        transparent = opts.transparent or true,
        theme = opts.theme or "retrowave",
        glow = opts.glow or false,
        overrides = function(c, color)
            local blend = color.blend
            local darken = color.darken
            local alpha = 0.2

            local debug = c.pink
            local trace = c.purple

            return {
                FoldColumn = { fg = "#c1e2ff", bg = "NONE" },
                NotifyERRORBorder = { fg = blend(c.diag.error, c.bgdark, alpha) },
                NotifyWARNBorder = { fg = blend(c.diag.warning, c.bgdark, alpha) },
                NotifyINFOBorder = { fg = blend(c.diag.info, c.bgdark, alpha) },
                NotifyDEBUGBorder = { fg = blend(debug, c.bgdark, alpha) },
                NotifyTRACEBorder = { fg = blend(trace, c.bgdark, alpha) },
                DapStoppedLinehl = { fg = c.white, bg = c.red },
                WinSeparator = { bg = "NONE" },

                TelescopeBorder = { fg = c.bgdark, bg = c.bgdark },
                TelescopePreviewBorder = { fg = c.red, bg = c.bgdark },
                TelescopePromptBorder = { fg = c.red, bg = c.bgdark },
                TelescopeNormal = { fg = c.red, bg = c.bgdark },

                WhichKey = { fg = c.red },

                -- NormalFloat = { bg = "NONE" },
            }
        end,
    })
    vim.cmd.colorscheme("fluoromachine")
end

return M
