local cf = require("common.functions")

local function setup_whichkey_root()
	local root_defs = {
		{ "<leader>a", group = "[A]erial" },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]iagnostics & Debugging" },
		{ "<leader>db", group = "De[B]ug" },
		{ "<leader>dv", group = "Diff[V]iew" },
		{ "<leader>e", group = "[E]dit Files" },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>p", group = "[P]roject Management" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>se", group = "[E]xtensions" },
		{ "<leader>sed", group = "[D]ap" },
		{ "<leader>sf", group = "[F]iles" },
		{ "<leader>sg", group = "[G]it" },
		{ "<leader>u", group = "[U]nit Testing" },
		{ "<leader>v", group = "[V]irtual environment" },
		{ "<leader>t", group = "[T]rouble" },
		{ "<leader>q", group = "[Q]uick Fix" },
		{ "<leader>n", group = "[N]ode operations" },
        { "<leader>i", group = "[I]nternet Browsing"},
        { "<C-g>", group = "AI [G]pt"},
	}
	local km_telescope = require("config.keymaps.telescope")
	local wk = require("which-key")
	wk.add(root_defs)
	wk.add(km_telescope.root_whichkey())
end

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
	cf.mapn("<leader>ap", "ea", "Append to word")
	cf.mapn("<leader>pp", "wbi", "Prepend to word")

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
		local km_telescope = require("config.keymaps.telescope")
		local km_git = require("config.keymaps.git")
		local km_misc = require("config.keymaps.misc_plugins")
        local km_ai = require("config.keymaps.ai_keymaps")
		km_telescope.config()
		km_git.config()
		km_misc.config()
        km_ai.config()
		setup_whichkey_root()
	end,
}
