local M = {}

M.warp_theme_path = vim.fn.stdpath('config') .. '/colors/warp/'

local function make_transparent()
    local groups = {
        -- Normal is the main background
        "Normal",
        "NormalFloat",
        "SignColumn",
        "NormalNC",
        -- Neovim UI elements
        "LineNr",
        "FoldColumn",
        "EndOfBuffer",
        "VertSplit",
        "StatusLine",
        "StatusLineNC",
        -- Floating windows
        "Pmenu",
        "FloatBorder",
        -- Git signs
        "GitSignsAdd",
        "GitSignsChange",
        "GitSignsDelete",
        -- LSP diagnostics background
        "DiagnosticVirtualTextError",
        "DiagnosticVirtualTextWarn",
        "DiagnosticVirtualTextInfo",
        "DiagnosticVirtualTextHint",
    }

    for _, group in ipairs(groups) do
        local current = vim.api.nvim_get_hl(0, { name = group })

        if current.bg then
            current.bg = nil
        end

        if current.ctermbg then
            current.ctermbg = nil
        end

        vim.api.nvim_set_hl(0, group, current)
    end
end

function M.setup(opts)
    opts = opts or {}
    local filename = opts.filename or "hotspring"

    local warp = require("warp-theme-nvim")
    warp.setup({
        theme_link = M.warp_theme_path .. filename .. '.yaml',
    })

    make_transparent()
end

return M
