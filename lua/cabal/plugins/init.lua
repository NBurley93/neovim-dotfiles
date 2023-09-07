return {
	config = function()
		require("cabal.plugins.pluglist")

		-- Make required `setup` calls here

		local ts = require("telescope")
		ts.load_extension("ui-select")
	end,
}
