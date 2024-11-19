local cf = require("common.functions")

local function return_version()
	local version = vim.version()
	return " v" .. version.major .. "." .. version.minor .. "." .. version.patch
end

local SHOW_DASHBOARD_ARTWORK = function()
	local envvars = vim.env
	if cf.setContainsKey(envvars, "CNVIM_HIDE_ARTWORK") then
		return envvars.CNVIM_HIDE_ARTWORK == "0"
	else
		return true
	end
end

local dashboard_artwork = {
	[[]],
	[[ ⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂ ]],
	[[ ⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕ ]],
	[[ ⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂ ]],
	[[ ⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂ ]],
	[[ ⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔ ]],
	[[ ⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿ ]],
	[[ ⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿ ]],
	[[ ⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃ ]],
	[[ ⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈ ]],
	[[ ⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈ ]],
	[[ ⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈ ]],
	[[ ⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈ ]],
	[[ ⠨⡂⡀⢑⢕⡅⠂⠄⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿⠠⠈ ]],
	[[ ⠄⠪⣂⠁⢕⠆⠄⠂⠄⠁⡀⠂⡀⠄⢈⠉⢍⢛⢛⢛⢋⢔⢕⢕⢕⣽⣿⣿⠠⠈ ]],
	[[]],
}

return {
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			local logo = {}
			if SHOW_DASHBOARD_ARTWORK() then
				for _, item in ipairs(dashboard_artwork) do
					table.insert(logo, item)
				end
			end
			table.insert(logo, [[]])
			table.insert(logo, "  Neovim" .. return_version())
			table.insert(logo, [[]])

			local hyper_cfg = {
				header = logo,
				packages = {
					enable = true,
				},
				project = {
					enable = false,
				},
				mru = { enable = false, },
				shortcut = {
					{
						icon = " ",
						desc = "Plugin Manager",
						action = "Lazy",
						key = "p",
					},
					{
						icon = " ",
						desc = "Mason Package Manager",
						action = "Mason",
						key = "m",
					},
					{
						icon = "󰱼 ",
						desc = "Files",
						action = "Telescope find_files",
						key = "f",
					},
					{
						icon = "󰙅 ",
						desc = "Filetree",
						action = "Oil",
						key = "t",
					},
					{
						icon = "󱩾 ",
						desc = "Grep Search",
						action = "Telescope grep_string",
						key = "g"
					},
					{
						icon = " ",
						desc = "Check for new Neovim release",
						action = "W3mSplit https://github.com/neovim/neovim/releases",
						key = "r",
					},
					{
						icon = " ",
						desc = "Check Health",
						action = "checkhealth",
						key = "h",
					},
				},
			}

			require("dashboard").setup({
				theme = "hyper",
				config = hyper_cfg,
			})
		end,
		dependencies = { require("common.defines").WEB_DEVICONS_PROVIDER, },
	},
}
