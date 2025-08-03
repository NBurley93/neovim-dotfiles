local cf = require("common.functions")

local function base_mappings()
    -- Nop leader key
    -- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

    -- Scroll pages with the cursor on the center of the page
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")

    -- Reconfigure search next & prev to center the find result on the screen
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")

    -- Preserve visual selection when indenting
    vim.keymap.set("v", ">", ">gv")
    vim.keymap.set("v", "<", "<gv")

    -- Bindings to allow us to append/prepend to a word
    vim.keymap.set("n", "<leader>wa", "ea", { desc = "Append to word"})
    vim.keymap.set("n", "<leader>wp", "wbi", { desc = "Prepend to word"})

    vim.keymap.set("n", "<leader>wr", function()
        cf.attempt_write(function()
            vim.cmd("noa w")
        end)
    end, { desc = "Write buffer without running autocmds (raw)"})

    vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

    -- Ergonomic underscore
    vim.keymap.set("i", "<S-Space>", "_", { desc = "Underscore", noremap = true, })

    -- Window navigation
    vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
    vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
    vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })
    vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })

    -- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
    vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move current line up" })
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })

    -- The BEST remap ever!!!
    vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Put without replacing paste buffer" })
end

return {
    config = function()
        base_mappings()
        require('config.keymaps.telescope').config()
        require('config.keymaps.git').config()
        require('config.keymaps.misc_plugins').config()
    end,
}
