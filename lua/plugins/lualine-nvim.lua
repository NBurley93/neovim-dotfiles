local function setup_line_segments()
    return {
        lualine_a = {
            {
                "mode",
                icons_enabled = true,
                fmt = function(str)
                    if str == "V-BLOCK" then
                        return "VB"
                    elseif str == "V-LINE" then
                        return "VL"
                    else
                        return str:sub(1, 1)
                    end
                end,
            },
        },
        lualine_b = {
            {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
            },
            {
                "b:gitsigns_head",
                icon = "",
            },
            {
                "diff",
                colored = true,
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
            },
            {
                "filename",
                file_status = true,
                path = 1,
                symbols = {
                    modified = "󱇧",
                    readonly = "󰈡 ",
                    unnamed = "[Unnamed]",
                    newfile = "[New]",
                },
            },
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },
            },
        },
        lualine_c = {
            {
                'lsp_status',
                icon = '', -- f013
                symbols = {
                    -- Standard unicode symbols to cycle through for LSP progress:
                    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                    -- Standard unicode symbol for when LSP is done:
                    done = '✓',
                    -- Delimiter inserted between LSP names:
                    separator = ' ',
                },
                -- List of LSP names to ignore (e.g., `null-ls`):
                ignore_lsp = {},
            }
        },
        lualine_x = {
            {
                "fileformat",
                symbols = {
                    unix = "",
                    dos = "",
                    mac = "",
                }
            },
            "encoding",
            { "filetype", colored = true },
        },
        lualine_y = { "progress",
            {
                "searchcount",
                maxcount = 999,
                timeout = 500,
            },
        },
        lualine_z = { "location" },
    }
end

local function setup_options()
    return {

        icons_enabled = true,
        component_separators = "│",
        globalstatus = true,
        disabled_filetypes = { "lazy", "noice" },
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    }
end

return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = require("common.defines").WEB_DEVICONS_PROVIDER,
        opts = {
            options = setup_options(),
            sections = setup_line_segments(),
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = { "fugitive", "trouble", "lazy", "mason", "oil" },
        },
    },
}
