return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		map("<leader>us", function()
			require("neotest").summary.open()
		end, "Open unit-test summary window")

		map("<leader>ut", function()
			require("neotest").run.run()
		end, "Run the nearest unit-test")

		map("<leader>uT", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, "Run all unit-tests in the active buffer's file")

		map("<leader>ud", function()
			require("neotest").run.run({ strategy = "dap" })
		end, "Run test with dap-ui debugging")

		map("<leader>uD", function()
			require("neotest").run.run({ strategy = "dap" })
		end, "Run all tests in file with dap-ui debugging")
	end,
}
