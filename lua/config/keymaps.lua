return {
	config = function()
		local cmp = require("cmp")
		local dap = require("dap")
		local dapui = require("dapui")
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "Q", "<nop>")

		map("n", "<C-d>", "<C-d>zz")
		map("n", "<C-u>", "<C-u>zz")
		map("n", "n", "nzzzv")
		map("n", "N", "Nzzzv")

		map("n", "<leader><leader>", function()
			vim.cmd("so")
		end, { desc = "Re-source this file" })

		map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

		-- Code overview binds
		map("n", "<leader>av", function()
			vim.cmd.AerialToggle("right")
		end, { desc = "Toggle Aerial view" })

		-- Save file as
		map("n", "<leader>es", function()
			vim.cmd.saveas(vim.fn.input({ prompt = "Filename > ", text = vim.fn.expand("%:p") }))
		end, { desc = "Saveas file" })

		-- Create new file buffer
		map("n", "<leader>en", function()
			vim.cmd.e(vim.fn.input({ prompt = "Filename > ", text = "newfile" }))
		end, { desc = "Create new file" })

		-- Git
		map("n", "<leader>ga", function()
			local toStage = vim.fn.expand("%:p")
			vim.cmd.Git("add " .. toStage)
			print("Staged " .. toStage)
		end, { desc = "Add currently open file to git staged" })
		map("n", "<leader>gc", function()
			vim.cmd.Git("commit")
		end, { desc = "Makes a git commit" })
		map("n", "<leader>gs", vim.cmd.Git, { desc = "Open up fugitive for git" })
		map("n", "<leader>gp", function()
			vim.cmd.Git("-c push.default=current push")
		end, { desc = "Push to git-remote" })
		map("n", "<leader>gP", function()
			vim.cmd.Git("pull")
		end, { desc = "Pull from git-remote" })
		map("n", "<leader>gd", vim.cmd.Gdiffsplit, { desc = "Open up Gdiff in vim-fugitive for the current file" })
		map("n", "<leader>gr", function()
			vim.cmd.Git("diff --staged")
		end, { desc = "Show a review diff for all our staged changes" })
		map("n", "<leader>gb", function()
			vim.cmd.Git("branch ")
		end, { desc = "Git branch" })
		map("n", "<leader>go", function()
			vim.cmd.Git("checkout ")
		end, { desc = "Git checkout" })

		-- Code annotation
		map("n", "<leader>ca", function()
			require("neogen").generate()
		end, { desc = "Generate code annotation" })

		-- Trouble
		map("n", "<leader>xx", vim.cmd.TroubleToggle, { desc = "Toggle Trouble window" })

		-- Overseer
		map("n", "<leader>or", vim.cmd.OverseerRun, { desc = "Run from Overseer Tasks" })
		map("n", "<leader>ot", vim.cmd.OverseerToggle, { desc = "Toggle Overseer List" })
		map("n", "<C-B>", vim.cmd.OverseerRun, { desc = "Overseer Task Shortcut" })

		-- Shortcut to exit insert mode
		map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

		map("n", "<leader>pv", function()
			vim.cmd.Oil()
		end, { desc = "View project directory" })
		-- nvim-cmp Mappings
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			}),
		})

		-- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
		map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move current line up" })
		map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })

		-- Git
		map("n", "<leader>dvo", vim.cmd.DiffviewOpen, { desc = "Review diffs in diffview" })
		map("n", "<leader>dvc", vim.cmd.DiffviewClose, { desc = "Close diffview if open" })

		-- Folds
		map("n", "zR", require("ufo").openAllFolds, { desc = "Open all Folds (UFO)" })
		map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all Folds (UFO)" })

		-- Telescope
		local telescope = require("telescope")
		map("n", "<leader>pf", builtin.find_files, { desc = "Find files in project" })
		map("n", "<C-p>", function()
			builtin.git_files({ show_untracked = true })
		end, { desc = "Only search for files that are unignored by git" })
		map("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Perform a grep string search thru project" })
		map("n", "<leader>vh", builtin.help_tags, { desc = "Search help tags" })
		map("n", "<leader>se", function()
			vim.cmd.Telescope("emoji")
		end, { desc = "Find emojis" })
		map("n", "<leader>vat", function()
			vim.cmd.Telescope("terraform_doc", "full_name=hashicorp/aws")
		end, { desc = "Search AWS Terraform Docs" })
		map("n", "<leader>sm", function()
			vim.cmd.Telescope("http", "list")
		end, { desc = "Telescope - Http Status Codes" })
		map("n", "<leader>sgb", function()
			builtin.git_branches({ show_remote_tracking_branches = false })
		end, { desc = "Search git branches" })
		map("n", "<leader>sgB", function()
			builtin.git_branches({ show_remote_tracking_branches = true })
		end, { desc = "Search git branches - Including upstream" })
		map("n", "<leader>sb", function()
			builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
		end, { desc = "Show open buffers" })
		map("n", "<leader>vn", function()
			telescope.extensions.notify.notify()
		end, { desc = "Show notify message history" })

		-- DAP Mappings
		map("n", "<F5>", dap.continue, { desc = "DapUI - Continue" })
		map("n", "<F1>", dap.step_into, { desc = "DapUI - Step Into" })
		map("n", "<F2>", dap.step_over, { desc = "DapUI - Step Over" })
		map("n", "<F3>", dap.step_out, { desc = "DapUI - Step Out" })
		map("n", "<leader>bp", dap.toggle_breakpoint, { desc = "DapUI - Set Breakpoint" })
		map("n", "<leader>BP", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DapUI - Set Conditional Breakpoint" })
		map("n", "<leader>db", dapui.open, { desc = "DapUI - Open" })
		map("n", "<leader>dbc", dapui.close, { desc = "DapUI - Close" })
		map("n", "<leader>dbe", dapui.eval, { desc = "DapUI - Eval" })

		-- Whichkey
		map("n", "<leader>wk", "<cmd>WhichKey<cr>", { desc = "Open whichkey window" })

		-- Neotest
		map("n", "<leader>us", function()
			require("neotest").summary.open()
		end, { desc = "Open unit-test summary window" })

		map("n", "<leader>ut", function()
			require("neotest").run.run()
		end, { desc = "Run the nearest unit-test" })
		map("n", "<leader>uT", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Run all unit-tests in the active buffer's file" })

		map("n", "<leader>ud", function()
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "Run test with dap-ui debugging" })
		map("n", "<leader>uD", function()
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "Run all tests in file with dap-ui debugging" })

		-- The BEST remap ever!!!
		map("x", "<leader>p", [["_dP]], { desc = "Put without replacing paste buffer" })
	end,
}
