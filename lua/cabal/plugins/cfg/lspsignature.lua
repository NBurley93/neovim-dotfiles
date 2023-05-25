require('lsp_signature').setup({
	wrap = false,
	hint_prefix = '> ',
	hint_scheme = 'String',
	hi_parameter = 'LspSignatureActiveParameter',
	hint_enable = false,
	floating_window_above_cur_line = true,
	transparency = 0,
	handler_opts = {
		border = 'none',
	},
	padding = '  ',
	floating_window_off_x = 5,
	floating_window_off_y = function()
		local linenr = vim.api.nvim_win_get_cursor(0)[0]
		local pumheight = vim.o.pumheight
		local winline = vim.fn.winline()
		local winheight = vim.fn.winheight(0)

		-- window top
		if winline - 1 < pumheight then
			return pumheight
		end

		--Window bottom
		if winheight - winline < pumheight then
			return -pumheight
		end
		return 0
	end,
})
