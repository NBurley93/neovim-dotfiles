local commonfuncs = require("common.functions")

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
	}
	root_defs = vim.tbl_deep_extend("force", root_defs, require("config.keymaps.telescope").root_whichkey())

	require("which-key").register(root_defs)
end

local function base_mappings()
	local map = function(keys, action, desc)
		vim.keymap.set("n", keys, action, { desc = desc })
	end

	local mapv = function(keys, action, desc)
		vim.keymap.set("v", keys, action, { desc = desc })
	end

	local mapx = function(keys, action, desc)
		vim.keymap.set("x", keys, action, { desc = desc })
	end

	-- Nop both Q and our leader key
	vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
	vim.keymap.set("n", "Q", "<nop>")

	-- Scroll pages with the cursor on the center of the page
	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("n", "<C-u>", "<C-u>zz")

	-- Reconfigure search next & prev to center the find result on the screen
	vim.keymap.set("n", "n", "nzzzv")
	vim.keymap.set("n", "N", "Nzzzv")

	-- File write operations
	map("<leader>wb", function()
		commonfuncs.attempt_write(vim.cmd.w)
	end, "Write current buffer")
	map("<leader>wq", function()
		commonfuncs.attempt_write(vim.cmd.wq)
	end, "Write current buffer and quit")

	map("<Esc>", vim.cmd.nohlsearch, "Clear search highlight")

	-- Quit ops
	map("<leader>qq", vim.cmd.qall, "Quit neovim, unless there are buffer changes")
	map("<leader>qf", function()
		vim.cmd("qall!")
	end, "Force-quit neovim even with buffer changes. VERY DANGEROUS")
	map("<leader>qw", vim.cmd.q, "Quit current window")

	-- Window navigation
	map("<C-h>", "<C-w><C-h>", "Move focus to left window")
	map("<C-j>", "<C-w><C-j>", "Move focus to lower window")
	map("<C-k>", "<C-w><C-k>", "Move focus to upper window")
	map("<C-l>", "<C-w><C-l>", "Move focus to right window")

	-- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
	mapv("K", ":m '>-2<CR>gv=gv", "Move current line up")
	mapv("J", ":m '>+1<CR>gv=gv", "Move current line down")

	-- The BEST remap ever!!!
	mapx("<leader>p", [["_dP]], "Put without replacing paste buffer")
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
