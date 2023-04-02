return {
	config = function()
		require('cabal.plugins.pluglist')

		-- Make required `setup` calls here
		require('Comment').setup()
	end,
}
