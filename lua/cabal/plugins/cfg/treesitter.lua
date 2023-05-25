require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'regex', 'bash', 'markdown', 'markdown_inline', 'python' },

	sync_install = false,

	auto_install = false,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},

		additional_vim_regex_highlighting = false,
	},
}
