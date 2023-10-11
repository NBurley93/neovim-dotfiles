-- local Color, colors, Group, groups, styles = require("colorbuddy").setup()

local function setup_colorscheme_augroup()
	vim.cmd([[
				augroup color_scheme_tweaks
					autocmd!
					autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
					" autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE guifg=#2e2225
					" autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
					" autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
					" autocmd ColorScheme * hi MsgArea guibg=NONE
					" autocmd ColorScheme * hi NormalNC guibg=NONE
					" autocmd ColorScheme * hi VertSplit guibg=NONE
					" autocmd ColorScheme * hi ErrorMsg guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * hi NvimTreeNormal guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * hi FloatBorder guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * hi TelescopeBorder guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * hi NoiceCmdlinePopupBorderSearch guibg=NONE ctermbg=NONE
					" autocmd ColorScheme * hi CursorLine guibg=#050a08
					" autocmd ColorScheme * highlight NoiceCmdlinePopupBorder ctermbg=None guibg=None
					" autocmd ColorScheme * highlight NoiceCmdlinePopupTitle ctermbg=None guibg=None
				" augroup END
				]])
end

return {
	config = function()
		-- require("kanagawa").load("wave")
		require("themes.neonwave").use()

		-- vim.cmd('colorscheme cyberpunk_scarlet')
		-- vim.cmd('colorscheme 2077')
		-- vim.cmd('colorscheme hackerman')
		-- require('onedark').load({
		-- 	style = 'warmer'
		-- })
		-- vim.cmd("colorscheme nightfox")
		-- vim.cmd("colorscheme aurora")
		-- vim.cmd("colorscheme duskfox")
	end,
}
