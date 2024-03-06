local nvim_map = vim.keymap.set

local nvim_cmd = vim.cmd

local nvim_input = vim.fn.input

local nvim_notify_warn = function(msg)
	vim.notify(msg, vim.log.levels.WARN)
end

--[[ local nvim_notify_error = function(msg)
	vim.notify(msg, vim.log.levels.ERROR)
end ]]

local nvim_notify_info = function(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

-- Git
local function git_mappings()
	nvim_map("n", "<leader>ga", function()
		local toStage = vim.fn.expand("%:p")
		nvim_cmd.Git("add " .. toStage)
		print("Staged " .. toStage)
	end, { desc = "Add currently open file to git staged" })

	nvim_map("n", "<leader>gc", function()
		nvim_cmd.Git("commit")
	end, { desc = "Makes a git commit" })

	nvim_map("n", "<leader>gs", nvim_cmd.Git, { desc = "Open up fugitive for git" })

	nvim_map("n", "<leader>gp", function()
		nvim_cmd.Git("-c push.default=current push")
	end, { desc = "Push to git-remote" })

	nvim_map("n", "<leader>gP", function()
		nvim_cmd.Git("pull")
	end, { desc = "Pull from git-remote" })

	nvim_map("n", "<leader>gd", nvim_cmd.Gdiffsplit, { desc = "Open up Gdiff in vim-fugitive for the current file" })

	nvim_map("n", "<leader>gr", function()
		nvim_cmd.Git("diff --staged")
	end, { desc = "Show a review diff for all our staged changes" })

	nvim_map("n", "<leader>gb", function()
		nvim_cmd.Git("branch ")
	end, { desc = "Git branch" })

	nvim_map("n", "<leader>go", function()
		nvim_cmd.Git("checkout ")
	end, { desc = "Git checkout" })

	nvim_map("n", "<leader>dvo", nvim_cmd.DiffviewOpen, { desc = "Review diffs in diffview" })

	nvim_map("n", "<leader>dvc", nvim_cmd.DiffviewClose, { desc = "Close diffview if open" })
end

-- Telescope
local function telescope_mappings()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")

	nvim_map("n", "<leader>pf", builtin.find_files, { desc = "Files search" })

	nvim_map("n", "<C-p>", function()
		local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
		if ret == 0 then
			builtin.git_files({ show_untracked = true })
		else
			nvim_notify_info("Not a git repository, defaulting to find_files instead!")
			builtin.find_files()
		end
	end, { desc = "Search git files" })

	nvim_map("n", "<leader>ps", function()
		builtin.grep_string({ search = nvim_input("Grep > ") })
	end, { desc = "Grep search in files" })

	nvim_map("n", "<leader>sh", builtin.help_tags, { desc = "Help tags" })
	nvim_map("n", "<leader>ses", function()
		nvim_cmd.Telescope("symbols")
	end, { desc = "Symbols" })

	nvim_map("n", "<leader>set", function()
		nvim_cmd.Telescope("terraform_doc", "full_name=hashicorp/aws")
	end, { desc = "AWS Terraform Docs" })

	nvim_map("n", "<leader>seh", function()
		nvim_cmd.Telescope("http", "list")
	end, { desc = "Http status codes" })

	nvim_map("n", "<leader>sgb", function()
		builtin.git_branches({ show_remote_tracking_branches = false })
	end, { desc = "Branches" })

	nvim_map("n", "<leader>sgB", function()
		builtin.git_branches({ show_remote_tracking_branches = true })
	end, { desc = "Branches + upstream" })

	nvim_map("n", "<leader>sb", function()
		builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
	end, { desc = "Buffers" })

	nvim_map("n", "<leader>sec", function()
		nvim_cmd.Telescope("cheat", "fd")
	end, { desc = "cheat.sh" })

	nvim_map("n", "<leader>st", builtin.treesitter, { desc = "Treesitter" })

	nvim_map("n", "<leader>sB", builtin.builtin, { desc = "Builtin Telescope" })

	nvim_map("n", "<leader>sn", function()
		telescope.extensions.notify.notify()
	end, { desc = "Notification history" })
end

-- DAP
local function dap_mappings()
	local dap = require("dap")
	local dapui = require("dapui")
	nvim_map("n", "<F5>", dap.continue, { desc = "Continue" })
	nvim_map("n", "<F1>", dap.step_into, { desc = "Step into" })
	nvim_map("n", "<F2>", dap.step_over, { desc = "Step over" })
	nvim_map("n", "<F3>", dap.step_out, { desc = "Step out" })
	nvim_map("n", "<leader>dbb", dap.toggle_breakpoint, { desc = "Set breakpoint" })
	nvim_map("n", "<leader>dbB", function()
		dap.set_breakpoint(nvim_input("Breakpoint condition: "))
	end, { desc = "Set conditional breakpoint" })
	nvim_map("n", "<leader>dbo", dapui.open, { desc = "Open" })
	nvim_map("n", "<leader>dbc", dapui.close, { desc = "Close" })
	nvim_map("n", "<leader>dbe", dapui.eval, { desc = "Evaluate" })
end

-- neotest
local function neotest_mappings()
	nvim_map("n", "<leader>us", function()
		require("neotest").summary.open()
	end, { desc = "Open unit-test summary window" })

	nvim_map("n", "<leader>ut", function()
		require("neotest").run.run()
	end, { desc = "Run the nearest unit-test" })

	nvim_map("n", "<leader>uT", function()
		require("neotest").run.run(vim.fn.expand("%"))
	end, { desc = "Run all unit-tests in the active buffer's file" })

	nvim_map("n", "<leader>ud", function()
		require("neotest").run.run({ strategy = "dap" })
	end, { desc = "Run test with dap-ui debugging" })

	nvim_map("n", "<leader>uD", function()
		require("neotest").run.run({ strategy = "dap" })
	end, { desc = "Run all tests in file with dap-ui debugging" })
end

local function attempt_write(write_func)
	local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), "readonly")
	if is_modified == false then
		write_func()
	else
		nvim_notify_warn("Cannot write read-only buffer!")
	end
end

-- Config Shortcuts
local function config_shortcut_mappings()
	-- Allow re-sourcing a file from keybind
	nvim_map("n", "<leader><leader>s", function()
		nvim_cmd("so")
	end, { desc = "Re-source this file" })

	nvim_map("n", "<leader><leader>k", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua")
	end, { desc = "Open keybind config file" })

	nvim_map("n", "<leader><leader>l", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/lsp.lua")
	end, { desc = "Open lsp config file" })

	nvim_map("n", "<leader><leader>d", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/dap.lua")
	end, { desc = "Open dap config file" })

	nvim_map("n", "<leader><leader>c", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/completion.lua")
	end, { desc = "Open completion config file" })

	nvim_map("n", "<leader><leader>a", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/autocommands.lua")
	end, { desc = "Open autocommands config file" })

	nvim_map("n", "<leader><leader>n", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/null_ls.lua")
	end, { desc = "Open null-ls config file" })

	nvim_map("n", "<leader><leader>o", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/options.lua")
	end, { desc = "Open options config file" })

	nvim_map("n", "<leader><leader>t", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/lua/config/theming.lua")
	end, { desc = "Open theming config file" })

	nvim_map("n", "<leader><leader>i", function()
		nvim_cmd.e(vim.fn.stdpath("config") .. "/init.lua")
	end, { desc = "Open config init.lua" })

	nvim_map("n", "<leader><leader>p", function()
		require("oil").open(vim.fn.stdpath("config"))
	end, { desc = "Open configuration folder in Oil" })
end

local function base_mappings()
	-- Nop both Q and our leader key
	nvim_map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
	nvim_map("n", "Q", "<nop>")

	-- Scroll pages with the cursor on the center of the page
	nvim_map("n", "<C-d>", "<C-d>zz")
	nvim_map("n", "<C-u>", "<C-u>zz")

	-- File write operations
	nvim_map("n", "<leader>wb", function()
		attempt_write(nvim_cmd.w)
	end, { desc = "Write current buffer" })
	nvim_map("n", "<leader>wq", function()
		attempt_write(nvim_cmd.wq)
	end, { desc = "Write current buffer and quit" })

	nvim_map("n", "<Esc>", nvim_cmd.nohlsearch, { desc = "Clear search highlight" })

	-- Quit ops
	nvim_map("n", "<leader>qq", nvim_cmd.qall, { desc = "Quit neovim, unless there are buffer changes" })
	nvim_map("n", "<leader>qf", function()
		nvim_cmd("qall!")
	end, { desc = "Force-quit neovim even with buffer changes. VERY DANGEROUS" })

	nvim_map("n", "<leader>qw", nvim_cmd.q, { desc = "Quit current window" })

	-- Reconfigure search next & prev to center the find result on the screen
	nvim_map("n", "n", "nzzzv")
	nvim_map("n", "N", "Nzzzv")

	-- Window navigation
	nvim_map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
	nvim_map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
	nvim_map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })
	nvim_map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })

	-- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
	nvim_map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move current line up" })
	nvim_map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })

	-- The BEST remap ever!!!
	nvim_map("x", "<leader>p", [["_dP]], { desc = "Put without replacing paste buffer" })
end

local function minor_plugin_mappings()
	-- Whichkey
	nvim_map("n", "<leader>wk", "<cmd>WhichKey<cr>", { desc = "Open whichkey window" })

	-- Code overview binds
	nvim_map("n", "<leader>av", function()
		nvim_cmd.AerialToggle("right")
	end, { desc = "Toggle Aerial view" })

	-- Save file as
	nvim_map("n", "<leader>es", function()
		nvim_cmd.saveas(nvim_input({ prompt = "Filename > ", text = vim.fn.expand("%:p") }))
	end, { desc = "Saveas file" })

	-- Create new file buffer
	nvim_map("n", "<leader>en", function()
		nvim_cmd.e(nvim_input({ prompt = "Filename > ", text = "newfile" }))
	end, { desc = "Create new file" })

	-- Code annotation
	nvim_map("n", "<leader>ca", function()
		require("neogen").generate()
	end, { desc = "Generate code annotation" })

	-- Trouble
	nvim_map("n", "<leader>dt", nvim_cmd.TroubleToggle, { desc = "Toggle Trouble window" })

	-- Overseer
	nvim_map("n", "<leader>or", nvim_cmd.OverseerRun, { desc = "Run from Overseer Tasks" })
	nvim_map("n", "<leader>ot", nvim_cmd.OverseerToggle, { desc = "Toggle Overseer List" })
	nvim_map("n", "<C-B>", nvim_cmd.OverseerRun, { desc = "Overseer Task Shortcut" })

	-- Shortcut to exit insert mode
	nvim_map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

	-- Folds
	local ufo = require("ufo")
	nvim_map("n", "zR", ufo.openAllFolds, { desc = "Open all Folds (UFO)" })
	nvim_map("n", "zM", ufo.closeAllFolds, { desc = "Close all Folds (UFO)" })

	-- Oil
	nvim_map("n", "<leader>pv", function()
		nvim_cmd.Oil()
	end, { desc = "View project directory" })

	-- nvim-cmp Mappings
	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		}),
	})
end

return {
	config = function()
		base_mappings()
		config_shortcut_mappings()
		git_mappings()
		telescope_mappings()
		dap_mappings()
		neotest_mappings()
		minor_plugin_mappings()

		require("which-key").register({
			["<leader><leader>"] = { name = "[Config Shortcuts]", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>o"] = { name = "[O]verseer", _ = "which_key_ignore" },
			["<leader>e"] = { name = "[E]dit Files", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]rite Files", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]roject Management", _ = "which_key_ignore" },
			["<leader>a"] = { name = "[A]erial", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>q"] = { name = "[Q]uit", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>se"] = { name = "[E]xtensions", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]iagnostics & Debugging", _ = "which_key_ignore" },
			["<leader>db"] = { name = "De[B]ug", _ = "which_key_ignore" },
			["<leader>dv"] = { name = "Diff[V]iew", _ = "which_key_ignore" },
			["<leader>u"] = { name = "[U]nit Testing", _ = "which_key_ignore" },
			["<leader>sg"] = { name = "[G]it", _ = "which_key_ignore" },
		})
	end,
}
