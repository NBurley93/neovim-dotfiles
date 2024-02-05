return {
	config = function()
		require("plugins.pluglist")

		local ts = require("telescope")
		ts.load_extension("ui-select")
		ts.load_extension("terraform_doc")
		ts.load_extension("http")
		ts.load_extension("emoji")
	end,
}
