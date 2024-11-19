local setup_luasnip = function()
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

	luasnip.filetype_extend("cpp", { "c" })
end

return {
	config = function()
		require("lspkind").init()
		setup_luasnip()
	end,
}
