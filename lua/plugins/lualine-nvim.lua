local P = require("custom_themes.mallgoth.palette")

local function setup_line_segments()
    return {
        lualine_a = {
            {
                "mode",
                icons_enabled = true,
                fmt = function(str)
                    if str == "V-BLOCK" then
                        return "V-B"
                    elseif str == "V-LINE" then
                        return "V-L"
                    elseif str == "NORMAL" then
                        return "NRM"
                    elseif str == "INSERT" then
                        return "INS"
                    elseif str == "VISUAL" then
                        return "VIS"
                    else
                        return str:sub(1, 3).upper()
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
                diff_color = {
                    added = { fg = P.neon_green },
                    modified = { fg = P.sickly_yellow },
                    removed = { fg = P.rose_red },
                },
            },
            {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 1,
                symbols = {
                    modified = "●",
                    readonly = "",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn", "info", "hint" },
                diagnostics_color = {
                    error = { fg = P.harsh_magenta },
                    warn  = { fg = P.sickly_yellow },
                    info  = { fg = P.acid_teal },
                    hint  = { fg = P.sickly_yellow },
                },
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },
                colored = true,
                update_in_insert = false,
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
            },
        },
        lualine_x = {
            {
                "copilot",
                symbols = {
                    status = {
                        hl = {
                            enabled = { fg = P.acid_teal },
                            sleep = { fg = P.fg },
                            disabled = { fg = P.muted },
                            warning = { fg = P.sickly_yellow },
                            unknown = { fg = P.harsh_magenta },
                        },
                    },
                    spinners = "dots",
                    spinner_color = P.biohazard_lime,
                },
                show_colors = false,
                show_loading = true
            },
            "encoding",
            {
                "fileformat",
                symbols = {
                    unix = "",
                    dos = "",
                    mac = "",
                }
            },
            { "filetype", colored = true },
        },
        lualine_y = { "progress",},
        lualine_z = { "location" },
    }
end

local function setup_inactive_segments()
    return {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    }
end

local function setup_winbar_segments()
    return {
        lualine_a = {
            {
                "filetype",
                colored = false,
                icon_only = true,
                icon = { align = "right" },
            },
        },
        lualine_b = {
        },
        lualine_c = {
            {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 0,
                symbols = {
                    modified = "●",
                    readonly = "",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
end

local function get_theme()
    return require('custom_themes.mallgoth.plugins.lualine')
end

local function setup_options()
    return {
        icons_enabled        = true,
        -- component_separators = { left = "│", right = "│" },
        component_separators = "",
        section_separators   = { left = "", right = "" },
        globalstatus         = true,
        disabled_filetypes   = {
            statusline = {
                "lazy", "noice", "dashboard",
            },
            winbar = {
                "lazy", "noice", "oil",
            }
        },
        theme = get_theme(),
    }
end


return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            require("common.defines").WEB_DEVICONS_PROVIDER,
        },
        opts = {
            options = setup_options(),
            sections = setup_line_segments(),
            inactive_sections = setup_inactive_segments(),
            tabline = {},
            winbar = setup_winbar_segments(),
            inactive_winbar = setup_winbar_segments(),
            extensions = { "fugitive", "trouble", "lazy", "mason", "oil" },
            -- theme = 'lflops',
        },
    },
    {
        'AndreM222/copilot-lualine',
    }
}
