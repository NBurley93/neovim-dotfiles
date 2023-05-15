return {
	config = function()
		require('cabal.plugins.pluglist')

		-- Make required `setup` calls here
		require('Comment').setup()

		local ts = require('telescope')
		ts.load_extension('ui-select')
	end,
}
