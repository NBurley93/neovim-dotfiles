pcall(require("nvim-treesitter.install").update({ with_sync = true }))
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"vim",
		"vimdoc",
		"regex",
		"bash",
		"markdown",
		"markdown_inline",
		"python",
		"terraform",
		"go",
		"rust",
		"dockerfile",
	},

	sync_install = false,

	auto_install = false,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},

		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
