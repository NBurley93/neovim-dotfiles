return {
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				cmdline = {
					view = "cmdline_popup",
					format = {
						cmdline = { icon = "󰆍" },
						help = { icon = "󰠗" },
					},
				},
				presets = {
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
