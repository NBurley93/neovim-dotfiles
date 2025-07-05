local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function realpath(path)
    return vim.loop.fs_realpath(path) or path
end

local function CopilotAutocommands()
        -- Copilot blink.cmp completions
        autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                vim.b.copilot_suggestion_hidden = true
            end,
        })

        autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.b.copilot_suggestion_hidden = false
            end,
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
    end,
}
