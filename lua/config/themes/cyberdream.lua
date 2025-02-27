local M = {}

function M.setup(opts)
    opts = opts or {}

    local cyberdream = require("cyberdream")
    cyberdream.setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        terminal_colors = true,
        cache = false,

        theme = {
            variant = "default",
            overrides = function(colors)
                return {
                    Comment = { fg = colors.grey, bg = "NONE", italic = true },
                    Keyword = { fg = colors.blue, bg = "NONE" },
                    String = { fg = colors.orange, bg = "NONE" },
                    Type = { fg = "#4EC9B0", bg = "NONE" },
                    Function = { fg = "#A53FD6", bg = "NONE" },
                }
            end,
        },
    })
    vim.cmd.colorscheme("cyberdream")
end

return M
