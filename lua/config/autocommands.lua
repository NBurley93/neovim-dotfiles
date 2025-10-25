local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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
        end,
    })
end

local function AutoformatFTCommands()
    local afmt_group = augroup("autofmt_ft_group", { clear = true })

    autocmd({ "BufWritePost" }, {
        pattern = { "*.tex" },
        group = afmt_group,
        desc = "Automatically format LaTex files on save using tex-fmt",
        callback = function()
            local fname = vim.api.nvim_buf_get_name(0)
            local ok, err = pcall(function()
                vim.cmd(":silent !tex-fmt " .. vim.fn.shellescape(fname))
            end)
            if not ok then
                vim.notify("tex-fmt failed: " .. err, vim.log.levels.ERROR)
            end
        end,
    })
end

local function FtSpecificKeybinds()
    local grp = augroup("ftspecific_keybinds", { clear = true })

    autocmd({ "FileType" }, {
        pattern = { "c", "cpp" },
        group = grp,
        desc = "Ouroboros keybinds for CPP",
        callback = function()
            vim.keymap.set("n", "<C-e>", function()
                vim.cmd.Ouroboros()
            end, { desc = "Toggle Ouroboros" })
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

        FtSpecificKeybinds()
        CopilotAutocommands()
        AutofixFiletypeCommands()
        AutoformatFTCommands()
    end,
}
