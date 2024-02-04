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
				icon_hl = "DevIconNPMrc",
				desc = "View plugins with Lazy",
				action = "Lazy",
			},
			{
				icon = " ",
				icon_hl = "DevIconDoc",
				desc = "Manage 3rd Party integrations with Mason",
				action = "Mason",
			},
			{
				icon = " ",
				icon_hl = "DevIconCoffee",
				desc = "Check NVIM's health",
				action = "checkhealth",
			},
			{
				icon = " ",
				icon_hl = "DevIconMint",
				desc = "Browse this folder",
				action = "Oil",
			},
			{
				icon = " ",
				icon_hl = "DevIconAi",
				desc = "Find File in this folder with Telescope",
				action = "Telescope find_files",
			},
			{
				icon = " ",
				icon_hl = "DevIconCpp",
				desc = "Search files for pattern with Telescope's live grep search",
				action = "Telescope live_grep",
			},
		},
	},
})
