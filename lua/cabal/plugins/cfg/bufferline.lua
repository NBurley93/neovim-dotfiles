require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "Directory",
				separator = true,
				text_align = "left",
			},
			{
				filetype = "dapui_breakpoints",
				text = "Breakpoints",
				separator = true,
				text_align = "center",
			},
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return " " .. icon .. count
		end,
		separator_style = "padded_slant",
		modified_icon = "●",
		show_close_icon = false,
		show_buffer_close_icons = false,
		highlights = {},
	},
})
