return {
	max_jobs = 10,
	display = {
		open_fn = function() return require('packer.util').float({ border = 'rounded' }) end,
		compact = true
	},
	lockfile = {
		enable = true,
		regen_on_update = true
	},
	profile = {
		enable = true,
		threshold = 1
	}
}
