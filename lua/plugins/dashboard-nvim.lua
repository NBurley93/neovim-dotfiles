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
			local utils = require("dashboard.utils")
			local package_manager_stats = utils.get_package_manager_stats()
			local logo = {}
			if SHOW_DASHBOARD_ARTWORK() then
				for _, item in ipairs(dashboard_artwork) do
					table.insert(logo, item)
				end
			end
			table.insert(logo, [[]])
			table.insert(logo, "  Neovim" .. return_version())
			table.insert(logo, [[]])

			require("dashboard").setup({
				theme = "doom",
				config = {
					header = logo,
					center = {
						{
							icon = " ",
							icon_hl = "DevIconZsh",
							desc = "Plugin Manager",
							action = "Lazy",
							key = "P",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = " ",
							icon_hl = "DevIconarduino",
							desc = "Mason Package Manager",
							action = "Mason",
							key = "M",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = "󱥃 ",
							icon_hl = "DevIconZig",
							desc = "What's new?",
							action = "help news",
							key = "N",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = " ",
							icon_hl = "DevIconZig",
							desc = "Check for new Neovim release",
							action = "Browse https://github.com/neovim/neovim/releases",
							key = "R",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = " ",
							icon_hl = "DevIconNPMrc",
							desc = "Check Health",
							action = "checkhealth",
							key = "H",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = "󰎚",
							icon_hl = "DevIconBlender",
							desc = "Neorg Notes",
							action = "Neorg workspace notes",
							key = "O",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = " ",
							icon_hl = "DevIconZsh",
							desc = "Vim Be Good",
							action = "VimBeGood",
							key = "G",
							key_hl = "group",
							key_format = " [%s]",
						},
						{
							icon = "󰩈 ",
							icon_hl = "DevIconNim",
							desc = "Quit",
							action = "qa!",
							key = "Q",
							key_hl = "group",
							key_format = " [%s]",
						},
					},
					footer = {
						"",
						" Startup-Time: " .. package_manager_stats.time .. " ms",
						"󰒲 Lazy: "
							.. package_manager_stats.loaded
							.. " loaded / "
							.. package_manager_stats.count
							.. " installed",
					},
				},
			})
		end,
		dependencies = { require("common.defines").WEB_DEVICONS_PROVIDER, "chrishrb/gx.nvim" },
	},
}
