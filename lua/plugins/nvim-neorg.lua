return {
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- default modules
					["core.concealer"] = {}, -- Adds icons to docs
					["core.dirman"] = { -- Manages workspaces
						config = {
							workspaces = {
								notes = os.getenv("HOME") .. "/neorg-notes",
							},
							index = "index.norg", -- main root file
						},
					},
				},
			})
		end,
	},
}
