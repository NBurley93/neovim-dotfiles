local builtin = require("statuscol.builtin")
require("statuscol").setup({
	segments = {
		-- Breakpoints
		{ sign = { name = { "Dap*" }, maxwidth = 1 } },
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
