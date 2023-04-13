require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		disabled_filetypes = { "packer", "NVimTree" },
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"buffers",
				show_modified_status = true,
				mode = 2,
				symbols = {
					modified = "!",
					alternate_file = "",
					directory = "",
				},
				use_mode_colors = false,
				buffers_color = {
					active = "TabLineSel",
					inactive = "TabLine",
				},
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "fugitive", "nvim-dap-ui", "nerdtree", "trouble" },
})
