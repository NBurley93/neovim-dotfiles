return {
	config = function()
		local cmp = require("cmp")
		local dap = require("dap")
		local dapui = require("dapui")
		local luasnip = require("luasnip")
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

		-- Aerial
		map("n", "<leader>av", function()
			vim.cmd.AerialToggle("right")
		end, { desc = "Toggle Aerial view" })

		-- Git
		map("n", "<leader>gs", vim.cmd.Git, { desc = "Open up fugitive for git" })
		map("n", "<leader>gp", function()
			vim.cmd.Git("push")
		end, { desc = "Push to git-remote" })

		-- Trouble
		map("n", "<leader>xx", vim.cmd.TroubleToggle, { desc = "Toggle Trouble window" })

		-- Overseer
		map("n", "<leader>or", vim.cmd.OverseerRun, { desc = "Run from Overseer Tasks" })
		map("n", "<leader>ot", vim.cmd.OverseerToggle, { desc = "Toggle Overseer List" })

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

		-- Git
		map("n", "<leader>dvo", vim.cmd.DiffviewOpen, { desc = "Review diffs in diffview" })
		map("n", "<leader>dvc", vim.cmd.DiffviewClose, { desc = "Close diffview if open" })

		-- Folds
		map("n", "zR", require("ufo").openAllFolds, { desc = "Open all Folds (UFO)" })
		map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all Folds (UFO)" })

		-- Telescope
		map("n", "<leader>pf", builtin.find_files, { desc = "Find files in project" })
		map("n", "<C-p>", builtin.git_files, { desc = "Only search for files that are unignored by git" })
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

		-- DAP Mappings
		map("n", "<F5>", dap.continue, { desc = "DapUI - Continue" })
		map("n", "<F1>", dap.step_into, { desc = "DapUI - Step Into" })
		map("n", "<F2>", dap.step_over, { desc = "DapUI - Step Over" })
		map("n", "<F3>", dap.step_out, { desc = "DapUI - Step Out" })
		map("n", "<leader>bp", dap.toggle_breakpoint, { desc = "DapUI - Set Breakpoint" })
		map("n", "<leader>BP", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DapUI - Set Conditional Breakpoint" })
		map("n", "<leader>dbg", dapui.open, { desc = "DapUI - Open" })
		map("n", "<leader>dbc", dapui.close, { desc = "DapUI - Close" })
		map("n", "<leader>dbe", dapui.eval, { desc = "DapUI - Eval" })
		map("n", "<leader>dbw", function()
			require("dap.ui.widgets").hover()
		end, { desc = "DapUI - Widgets" })

		-- Whichkey
		map("n", "<leader>wk", "<cmd>WhichKey<cr>", { desc = "Open whichkey window" })

		-- Neotest
		map("n", "<leader>ut", function()
			require("neotest").run.run()
		end)
		map("n", "<leader>uT", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end)
		map("n", "<leader>ud", function()
			require("neotest").run.run({ strategy = "dap" })
		end)

		-- The BEST remap ever!!!
		map("x", "<leader>p", [["_dP]], { desc = "Put without replacing paste buffer" })
	end,
}
