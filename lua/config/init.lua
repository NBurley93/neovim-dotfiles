local PROFILE_CONFIG_MODULES = false

local lzy_module = {
    config = function()
        require("lazy").setup("plugins", {
            ui = {
                border = "solid",
                icons = {
                    cmd = " ",
                    config = "",
                    debug = "● ",
                    event = " ",
                    favorite = " ",
                    ft = " ",
                    init = " ",
                    import = " ",
                    keys = " ",
                    lazy = "󰒲 ",
                    loaded = "●",
                    not_loaded = "○",
                    plugin = "󰀘 ",
                    runtime = " ",
                    require = "󰢱 ",
                    source = " ",
                    start = " ",
                    task = "✔ ",
                    list = {
                        "◆",
                        "▶",
                        "★",
                        "✖",
                    },
                },
            },
            dev = {
                path = "~/neovim-projects",
                patterns = {},
                fallback = true,
            },
        })
    end,
}

local config_module = function(key, module)
    return {
        key = key,
        module = module,
    }
end

local config_entries = {
    config_module('options', require('config.options')),
    config_module('plugins', lzy_module),
    config_module('postplugins', require('config.postplugins')),
    config_module('completion', require('config.completion')),
    config_module('lsp', require('config.lsp')),
    config_module('autocmd', require('config.autocommands')),
    config_module('keymaps', require('config.keymaps')),
    config_module('theming', require('config.theming')),
}

return {
    config_all = function()
        for _, entry in ipairs(config_entries) do
            local module = entry.module
            if module and type(module.config) == "function" then
                if PROFILE_CONFIG_MODULES == true then
                    local config_start_time = os.clock()
                end
                module.config()
                if PROFILE_CONFIG_MODULES == true then
                    local config_end_time = os.clock()
                    local config_elapsed_time = config_end_time - config_start_time
                    print(string.format("Module %s took %.4f seconds to configure", entry.key, config_elapsed_time))
                end
            else
                print('Skipping config module: ', entry.key, ' - config function missing or invalid')
            end
        end
    end,
}
