local function return_version()
	local version = vim.version()
	return " v" .. version.major .. "." .. version.minor .. "." .. version.patch
end

local SHOW_DASHBOARD_ARTWORK = false

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
			if SHOW_DASHBOARD_ARTWORK then
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
						},
						{
							icon = " ",
							icon_hl = "DevIconarduino",
							desc = "Mason Package Manager",
							action = "Mason",
						},
						{
							icon = "󱥃 ",
							icon_hl = "DevIconZig",
							desc = "What's new?",
							action = "help news",
						},
						{
							icon = " ",
							icon_hl = "DevIconNPMrc",
							desc = "Check Health",
							action = "checkhealth",
						},
						{
							icon = " ",
							icon_hl = "DevIconZsh",
							desc = "Vim Be Good",
							action = "VimBeGood",
						},
						{
							icon = "󰩈 ",
							icon_hl = "DevIconNim",
							desc = "Quit",
							action = "qa!",
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
		dependencies = { require("common.defines").WEB_DEVICONS_PROVIDER },
	},
}
