local cf = require("common.functions")

local function setup_whichkey_root()
	local root_defs = {
		{ "<leader>a", group = "[A]erial" },
		{ "<leader>a_", hidden = true },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>c_", hidden = true },
		{ "<leader>d", group = "[D]iagnostics & Debugging" },
		{ "<leader>d_", hidden = true },
		{ "<leader>db", group = "De[B]ug" },
		{ "<leader>db_", hidden = true },
		{ "<leader>dt", group = "[T]rouble" },
		{ "<leader>dt_", hidden = true },
		{ "<leader>dv", group = "Diff[V]iew" },
		{ "<leader>dv_", hidden = true },
		{ "<leader>e", group = "[E]dit Files" },
		{ "<leader>e_", hidden = true },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>g_", hidden = true },
		{ "<leader>o", group = "[O]verseer" },
		{ "<leader>o_", hidden = true },
		{ "<leader>p", group = "[P]roject Management" },
		{ "<leader>p_", hidden = true },
		{ "<leader>q", group = "[Q]uit Neovim" },
		{ "<leader>q_", hidden = true },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>s_", hidden = true },
		{ "<leader>se", group = "[E]xtensions" },
		{ "<leader>se_", hidden = true },
		{ "<leader>sed", group = "[D]ap" },
		{ "<leader>sed_", hidden = true },
		{ "<leader>sf", group = "[F]iles" },
		{ "<leader>sf_", hidden = true },
		{ "<leader>sg", group = "[G]it" },
		{ "<leader>sg_", hidden = true },
		{ "<leader>u", group = "[U]nit Testing" },
		{ "<leader>u_", hidden = true },
		{ "<leader>v", group = "[V]irtual environment" },
		{ "<leader>v_", hidden = true },
		{ "<leader>w", group = "[W]rite Buffers" },
		{ "<leader>w_", hidden = true },
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

	-- Bindings to allow us to append/prepend to a word
	cf.mapn("<leader>aw", "ea", "Append to word")
	cf.mapn("<leader>pw", "wbi", "Prepend to word")

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
