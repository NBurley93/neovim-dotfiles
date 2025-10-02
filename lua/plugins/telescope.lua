local icons = require('common.icons')

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
					layout_config = { prompt_position = "top", height = 0.92, width = 0.92 },
					layout_strategy = "flex",
					sorting_strategy = "ascending",
					winblend = 0,
					-- prompt_prefix = " ".. icons.ui.Telescope .. " ",
					-- selection_caret = "  ",
					results_title = "",
					dynamic_preview_title = true,
                    border = true,
                    color_devicons = true,
                    -- Solid border
                    -- borderchars = { "" },
                    prompt_prefix = "  ",     -- looks nice in neon; change if your font sulks
                    selection_caret = " ",
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
                pickers = {
                    find_files = { hidden = true },
                    buffers = { sort_lastused = true, ignore_current_buffer = true },
                    live_grep = { only_sort_text = true },
                    diagnostics = { theme = "dropdown" },
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
			ts.load_extension("undo")
            ts.load_extension("git_branch")
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "debugloop/telescope-undo.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "mrloop/telescope-git-branch.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
}
