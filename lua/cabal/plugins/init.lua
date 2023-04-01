vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost pluglist.lua source <afile> | PackerSync
	augroup end
	]])

require('cabal.plugins.pluglist')
