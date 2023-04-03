return {
	config = function()
		require('cabal.options').config()
		require('cabal.plugins').config()
		require('cabal.keymaps').config()
		require('cabal.theming').config()
		require('cabal.completion').config()
		require('cabal.lsp').config()
		require('cabal.autocommands').config()
		require('cabal.dap').config()
		require('cabal.null_ls').config()
	end,
}
