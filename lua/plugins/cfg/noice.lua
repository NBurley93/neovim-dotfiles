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
})
