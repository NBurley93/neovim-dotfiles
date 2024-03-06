return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		config = function(_, opts)
			local ts = require("telescope")
			ts.load_extension("ui-select")
			ts.load_extension("terraform_doc")
			ts.load_extension("http")
			ts.setup(opts)
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "ANGkeith/telescope-terraform-doc.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "barrett-ruth/telescope-http.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "nvim-telescope/telescope-symbols.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
}
