return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		local mapi = function(keys, action, desc)
			vim.keymap.set("i", keys, action, { desc = desc })
		end

		-- Aerial
		map("<leader>av", function()
			vim.cmd.AerialToggle()
		end, "Toggle aerial view")

		-- Whichkey
		map("<leader>wk", "<cmd>WhichKey<cr>", "Open whichkey window")

		-- treesj
		map("<leader>ns", function()
			require("treesj").split()
		end, "Split treesitter node into multilined statement")

		map("<leader>nj", function()
			require("treesj").join()
		end, "Joins a multiline treesitter node into a single-line statement")

		-- nvim-spectre
		map("<leader>ts", require("spectre").toggle, "[T]oggle [S]pectre")

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
		map("<leader>dtd", function()
			vim.cmd.Trouble("diagnostics", "toggle")
		end, "Toggle Trouble diagnostics window")

		map("<leader>dtq", function()
			vim.cmd.Trouble("qflist", "toggle")
		end, "Toggle Trouble quickfix list window")

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

		-- venv-selector
		map("<leader>vs", function()
			vim.cmd.VenvSelect()
		end, "[S]elect Python VEnv")

		-- w3m
		map("<leader>is", function()
			vim.cmd.W3mSplit(
				vim.fn.input({ prompt = "Search Engine Name (ref https://github.com/yuratomo/w3m.vim) >" }),
				vim.fn.input({ prompt = "Search Query > " })
			)
		end, "[I]nternet [S]earch")

		map("<leader>in", function()
			vim.cmd.W3mSplit(vim.fn.input({ prompt = "URL > " }))
		end, "[I]nternet [N]avigate")
	end,
}
