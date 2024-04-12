local function setup_line_segments()
	return {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"b:gitsigns_head",
				icon = "",
			},
			{
				"diff",
				colored = true,
				symbols = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			},
			{
				"filename",
				file_status = true,
				path = 0,
				symbols = {
					modified = "󱇧",
					readonly = "󰈡 ",
					unnamed = "[Unnamed]",
					newfile = "[New]",
				},
			},
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
		},
		lualine_c = {
			{
				"searchcount",
				maxcount = 999,
				timeout = 500,
			},
			function()
				return vim.fn["nvim_treesitter#statusline"](180)
			end,
		},
		lualine_x = {
			{ "datetime", style = "%I:%M:%S %p" },
			"encoding",
			{ "filetype", colored = true },
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	}
end

local function setup_options()
	return {

		icons_enabled = true,
		component_separators = "│",
		globalstatus = true,
		disabled_filetypes = { "lazy", "noice" },
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	}
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = require("common.defines").WEB_DEVICONS_PROVIDER,
		config = function()
			require("lualine").setup({
				options = setup_options(),
				sections = setup_line_segments(),
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "fugitive", "nvim-dap-ui", "trouble", "lazy", "mason", "oil", "overseer", "aerial" },
			})
		end,
	},
}
