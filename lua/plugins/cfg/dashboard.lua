local logo = {}
for _, item in ipairs(require("plugins.cfg.dashboard-art")) do
	table.insert(logo, item)
end

require("dashboard").setup({
	theme = "doom",
	config = {
		header = logo,
		center = {
			{
				icon = " ",
				icon_hl = "DevIconZsh",
				desc = "View plugins with Lazy",
				action = "Lazy",
			},
			{
				icon = " ",
				icon_hl = "DevIconarduino",
				desc = "Manage 3rd Party integrations with Mason",
				action = "Mason",
			},
			{
				icon = " ",
				icon_hl = "DevIconNPMrc",
				desc = "Check NVIM's health",
				action = "checkhealth",
			},
		},
	},
})
