local cf = require("common.functions")

local function base_mappings()
    -- Nop leader key
    vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

    -- Scroll pages with the cursor on the center of the page
    cf.mapn("<C-d>", "<C-d>zz")
    cf.mapn("<C-u>", "<C-u>zz")

    -- Reconfigure search next & prev to center the find result on the screen
    cf.mapn("n", "nzzzv")
    cf.mapn("N", "Nzzzv")

    -- Preserve visual selection when indenting
    cf.mapv(">", ">gv")
    cf.mapv("<", "<gv")

    -- Bindings to allow us to append/prepend to a word
    cf.mapn("<leader>wa", "ea", "Append to word")
    cf.mapn("<leader>wp", "wbi", "Prepend to word")

    cf.mapn("<leader>wr", function()
        cf.attempt_write(function()
            vim.cmd("noa w")
        end)
    end, "Write buffer without running autocmds (raw)")

    cf.mapn("<Esc>", vim.cmd.nohlsearch, "Clear search highlight")

    -- Window navigation
    cf.mapn("<C-h>", "<C-w><C-h>", "Move focus to left window")
    cf.mapn("<C-j>", "<C-w><C-j>", "Move focus to lower window")
    cf.mapn("<C-k>", "<C-w><C-k>", "Move focus to upper window")
    cf.mapn("<C-l>", "<C-w><C-l>", "Move focus to right window")

    -- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
    cf.mapv("K", ":m '>-2<CR>gv=gv", "Move current line up")
    cf.mapv("J", ":m '>+1<CR>gv=gv", "Move current line down")

    -- The BEST remap ever!!!
    cf.mapx("<leader>p", [["_dP]], "Put without replacing paste buffer")
end

return {
    config = function()
        base_mappings()
        require('config.keymaps.telescope').config()
        require('config.keymaps.git').config()
        require('config.keymaps.misc_plugins').config()
    end,
}
