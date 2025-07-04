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
				defaults = {
					layout_config = { prompt_position = "top" },
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					winblend = 0,
					prompt_prefix = "   ",
					selection_caret = "  ",
					results_title = "",
					dynamic_preview_title = true,
				},
				extensions = {
					aerial = {
						show_nesting = {
							["_"] = false,
							json = true,
							yaml = true,
							lua = true,
							xml = true,
						},
					},
				},
			})
			ts.load_extension("ui-select")
			ts.load_extension("terraform_doc")
			ts.load_extension("undo")
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "ANGkeith/telescope-terraform-doc.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "nvim-telescope/telescope-symbols.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "debugloop/telescope-undo.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
}
