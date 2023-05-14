local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
	config = function()
		local packer_user_config_group = augroup("packer_user_config", {})
		autocmd({ "BufWritePost" }, {
			pattern = "pluglist.lua",
			command = "source <afile> | PackerSync",
			group = packer_user_config_group,
		})
	end,
}
