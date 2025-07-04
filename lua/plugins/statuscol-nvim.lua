return {
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				segments = {
					-- Diagnostics
					{ sign = { name = { "Diagnostic.*" }, maxwidth = 1 } },
					-- Folds
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					-- Line num
					{
						text = { " ", builtin.lnumfunc },
						condition = { true, builtin.not_empty },
					},
					-- Gitsigns
					{
						sign = {
							namespace = { "gitsigns" },
							maxwidth = 1,
							colwidth = 1,
							wrap = true,
						},
					},
				},
			})
		end,
	},
}
