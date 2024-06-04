local cf = require("common.functions")

local function setup_whichkey_root()
	local root_defs = {
		["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
		["<leader>o"] = { name = "[O]verseer", _ = "which_key_ignore" },
		["<leader>w"] = { name = "[W]rite Buffers", _ = "which_key_ignore" },
		["<leader>q"] = { name = "[Q]uit Neovim", _ = "which_key_ignore" },
		["<leader>e"] = { name = "[E]dit Files", _ = "which_key_ignore" },
		["<leader>p"] = { name = "[P]roject Management", _ = "which_key_ignore" },
		["<leader>a"] = { name = "[A]erial", _ = "which_key_ignore" },
		["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
		["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
		["<leader>d"] = { name = "[D]iagnostics & Debugging", _ = "which_key_ignore" },
		["<leader>db"] = { name = "De[B]ug", _ = "which_key_ignore" },
		["<leader>dv"] = { name = "Diff[V]iew", _ = "which_key_ignore" },
		["<leader>u"] = { name = "[U]nit Testing", _ = "which_key_ignore" },
		["<leader>v"] = { name = "[V]irtual environment", _ = "which_key_ignore" },
	}
	root_defs = vim.tbl_deep_extend("force", root_defs, require("config.keymaps.telescope").root_whichkey())

	require("which-key").register(root_defs)
end

local function base_mappings()
	-- Nop both Q and our leader key
	vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
	cf.mapn("Q", "<nop>")

	-- Scroll pages with the cursor on the center of the page
	cf.mapn("<C-d>", "<C-d>zz")
	cf.mapn("<C-u>", "<C-u>zz")

	-- Reconfigure search next & prev to center the find result on the screen
	cf.mapn("n", "nzzzv")
	cf.mapn("N", "Nzzzv")

	-- File write operations
	cf.mapn("<leader>wb", function()
		cf.attempt_write(vim.cmd.w)
	end, "Write current buffer")
	cf.mapn("<leader>wq", function()
		cf.attempt_write(vim.cmd.wq)
	end, "Write current buffer and quit")

	cf.mapn("<Esc>", vim.cmd.nohlsearch, "Clear search highlight")

	-- Quit ops
	cf.mapn("<leader>qq", vim.cmd.qall, "Quit neovim, unless there are buffer changes")
	cf.mapn("<leader>qf", function()
		vim.cmd("qall!")
	end, "Force-quit neovim even with buffer changes. VERY DANGEROUS")
	cf.mapn("<leader>qw", vim.cmd.q, "Quit current window")

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
		require("config.keymaps.git").config()
		require("config.keymaps.telescope").config()
		require("config.keymaps.dap").config()
		require("config.keymaps.neotest").config()
		require("config.keymaps.misc_plugins").config()
		setup_whichkey_root()
	end,
}
