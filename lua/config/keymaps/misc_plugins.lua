return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		local mapi = function(keys, action, desc)
			vim.keymap.set("i", keys, action, { desc = desc })
		end

		-- Whichkey
		map("<leader>wk", "<cmd>WhichKey<cr>", "Open whichkey window")

		-- nvim-spectre
		map("<leader>ts", require("spectre").toggle, "[T]oggle [S]pectre")

		-- Code overview binds
		map("<leader>av", function()
			vim.cmd.AerialToggle("right")
		end, "Toggle Aerial view")

		-- Save file as
		map("<leader>es", function()
			vim.cmd.saveas(vim.fn.input({ prompt = "Filename > ", text = vim.fn.expand("%:p") }))
		end, "Saveas file")

		-- Create new file buffer
		map("<leader>en", function()
			vim.cmd.e(vim.fn.input({ prompt = "Filename > ", text = "newfile" }))
		end, "Create new file")

		-- Code annotation
		map("<leader>ca", function()
			require("neogen").generate()
		end, "Generate code annotation")

		-- Trouble
		map("<leader>dt", vim.cmd.TroubleToggle, "Toggle Trouble window")

		-- Overseer
		map("<leader>or", vim.cmd.OverseerRun, "Run from Overseer Tasks")
		map("<leader>ot", vim.cmd.OverseerToggle, "Toggle Overseer List")
		map("<C-O>", vim.cmd.OverseerRun, "Overseer Task Shortcut")

		-- Shortcut to exit insert mode
		mapi("<C-c>", "<Esc>", "Exit insert mode")

		-- Folds
		local ufo = require("ufo")
		map("zR", ufo.openAllFolds, "Open all Folds (UFO)")
		map("zM", ufo.closeAllFolds, "Close all Folds (UFO)")

		-- Oil
		map("<leader>pv", function()
			vim.cmd.Oil()
		end, "View project directory")

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
	end,
}
