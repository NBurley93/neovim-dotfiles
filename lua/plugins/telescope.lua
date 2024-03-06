return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		config = function()
			local ts = require("telescope")
			ts.setup({
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			})
			ts.load_extension("ui-select")
			ts.load_extension("terraform_doc")
			ts.load_extension("http")
			ts.load_extension("cheat")
			ts.load_extension("dap")
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "ANGkeith/telescope-terraform-doc.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "barrett-ruth/telescope-http.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "nvim-telescope/telescope-symbols.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{
		"nvim-telescope/telescope-cheat.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
	},
}
