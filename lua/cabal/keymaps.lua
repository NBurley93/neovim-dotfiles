return {
	config = function()
		local cmp = require("cmp")
		local dap = require("dap")
		local luasnip = require("luasnip")
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		local globals = vim.g

		-- Set <leader> to <Space>
		globals.mapleader = " "
		map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

		-- Misc helpers
		map(
			"n",
			"<leader>l",
			"<cmd>set invrelativenumber<cr>",
			{ desc = "Toggle between linenumber and rellinenumber" }
		)
		map(
			"n",
			"<leader><home>",
			"<cmd>luafile ~/nvim/init.lua<cr>",
			{ silent = false, desc = "Reload configuration" }
		)

		-- Trouble
		map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble window" })

		-- Diagnostic navigation
		map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
		map("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic message" })
		map("n", "<leader>e", vim.diagnostic.goto_prev, { desc = "Open floating diagnostic message" })
		map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

		-- Buffer mgmnt
		map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "Create a new empty buffer" })
		map("n", "<leader>b=", "<cmd>bnext<cr>", { desc = "Go to previous buffer" })
		map("n", "<leader>b-", "<cmd>bprev<cr>", { desc = "Go to next buffer" })
		map("n", "<leader>bc", "<cmd>bd<cr>", { desc = "Close the currently selected buffer" })

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

		-- Telescope
		map("n", "<leader>ff", builtin.find_files)
		map("", "<leader>fg", builtin.live_grep)
		map("n", "<leader>fb", builtin.buffers)
		map("n", "<leader>fh", builtin.help_tags)
		map("n", "<leader>/", builtin.current_buffer_fuzzy_find)

		-- DAP Mappings
		map("n", "<F5>", dap.continue)
		map("n", "<F1>", dap.step_into)
		map("n", "<F2>", dap.step_over)
		map("n", "<F3>", dap.step_out)
		map("n", "<leader>bp", dap.toggle_breakpoint)
		map("n", "<leader>BP", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
	end,
}
