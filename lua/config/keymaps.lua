return {
	config = function()
		local cmp = require("cmp")
		local dap = require("dap")
		local dapui = require("dapui")
		local luasnip = require("luasnip")
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		-- Disable command mode binding
		map("n", "q:", "<Nop>", { silent = true, desc = "Disable commandline window binding" })

		map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

		-- Misc helpers
		map(
			"n",
			"<leader>l",
			"<cmd>set invrelativenumber<cr>",
			{ desc = "Toggle between absolute and relative line numberings" }
		)

		-- Aerial
		map("n", "<leader>aa", "<cmd>AerialToggle! right<cr>", { desc = "Toggle Aerial" })

		-- Nerdtree
		map("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NERDTree Window" })

		-- Trouble
		map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble window" })

		-- Diagnostic navigation
		map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
		map("n", "<leader>dn", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic message" })

		-- Buffer mgmnt
		map("n", "<leader>bc", "<cmd>bprev <bar> bdelete #<cr>", { desc = "Close the currently selected buffer" })

		map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		-- nvim-cmp Mappings
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})

		-- Git
		map("n", "<leader>dvo", "<cmd>DiffviewOpen<cr>", { desc = "Review diffs in diffview" })
		map("n", "<leader>dvc", "<cmd>DiffviewClose<cr>", { desc = "Close diffview if open" })

		-- Telescope
		map("n", "<leader>sf", builtin.find_files)
		map("n", "<leader>sg", builtin.live_grep)
		map("n", "<leader>sb", builtin.buffers)
		map("n", "<leader>sh", builtin.help_tags)
		map("n", "<leader>/", builtin.current_buffer_fuzzy_find)

		map("n", "<C-Q>", "<cmd>qa<cr>", { desc = "Close neovim" })

		-- DAP Mappings
		map("n", "<F5>", dap.continue)
		map("n", "<F1>", dap.step_into)
		map("n", "<F2>", dap.step_over)
		map("n", "<F3>", dap.step_out)
		map("n", "<leader>bp", dap.toggle_breakpoint)
		map("n", "<leader>BP", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		map("n", "<leader>dbg", dapui.open)
		map("n", "<leader>dbc", dapui.close)

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
	end,
}
