local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function realpath(path)
    return vim.loop.fs_realpath(path) or path
end

local function CopilotAutocommands()
    local copilot_blink_group = augroup("copilot_blink_group", { clear = true })

    -- Copilot blink.cmp completions
    autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        group = copilot_blink_group,
        callback = function()
            vim.b.copilot_suggestion_hidden = true
        end,
    })

    autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        group = copilot_blink_group,
        callback = function()
            vim.b.copilot_suggestion_hidden = false
        end,
    })
end

local function AutofixFiletypeCommands()
    local ft_lsp_group = augroup("ft_lsp_group", { clear = true })

    autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
        group = ft_lsp_group,
        desc = "Automatically set docker-compose to use the yaml.docker-compose ft",
        callback = function()
            vim.opt.filetype = 'yaml.docker-compose'
        end
    })
end

return {
    config = function()
        -- Highlight on yank
        autocmd("TextYankPost", {
            desc = "Highlight when yanking text",
            group = augroup("highlight-yank", { clear = true }),
            callback = function()
                vim.highlight.on_yank({ higroup = "DiffviewStatusCopied", timeout = 250 })
            end,
        })

        CopilotAutocommands()
        AutofixFiletypeCommands()
    end,
}
