require('dashboard').setup({
	theme = 'doom',
	config = {
		header = {
			[[ _   _                 _           ]],
			[[| \ | | ___  _____   _(_)_ __ ___  ]],
			[[|  \| |/ _ \/ _ \ \ / / | '_ ` _ \ ]],
			[[| |\  |  __/ (_) \ V /| | | | | | |]],
			[[|_| \_|\___|\___/ \_/ |_|_| |_| |_|]],
			[[                                   ]],
		},
		center = {
			{
				icon = '  ',
				icon_hl = 'DevIconNPMrc',
				desc = 'Install Plugins from Lockfile',
				action = 'Lazy install',
			},
			{
				icon = '󱑥  ',
				icon_hl = 'DevIconJava',
				desc = 'Sync Plugins',
				action = 'Lazy sync',
			},
			{
				icon = '󱑥  ',
				icon_hl = 'DevIconDoc',
				desc = 'Update Mason',
				action = 'MasonUpdate',
			},
			{
				icon = '  ',
				icon_hl = 'DevIconCoffee',
				desc = 'Check health',
				action = 'checkhealth',
			},
			{
				icon = '  ',
				icon_hl = 'DevIconMint',
				desc = 'File Browser',
				action = 'NvimTreeToggle',
			},
			{
				icon = '󱓞  ',
				icon_hl = 'DevIconAi',
				desc = 'Find File',
				action = 'Telescope find_files',
			},
		},
	},
})
