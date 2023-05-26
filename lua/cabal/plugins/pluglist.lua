local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set <leader> to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('lazy').setup({
	-- Vim helpers
	{ 'folke/which-key.nvim' },

	-- Ui
	{
		{
			'akinsho/bufferline.nvim',
			version = '*',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require 'cabal.plugins.cfg.bufferline'
			end,
		},
		{
			'glepnir/dashboard-nvim',
			event = 'VimEnter',
			config = function()
				require('cabal.plugins.cfg.dashboard')
			end,
			dependencies = { 'nvim-tree/nvim-web-devicons' }
		},
		{
			'MaximilianLloyd/ascii.nvim',
			dependencies = { 'MunifTanjim/nui.nvim' },
		},
		{
			'nvim-lualine/lualine.nvim',
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('cabal.plugins.cfg.lualine')
			end,
		},
		{
			'rcarriga/nvim-notify',
			config = function()
				require 'cabal.plugins.cfg.notify'
			end,
		},
		{
			'folke/noice.nvim',
			config = function()
				require 'cabal.plugins.cfg.noice'
			end,
			dependencies = {
				'MunifTanjim/nui.nvim',
				'rcarriga/nvim-notify',
			},
		},
		{ 'stevearc/dressing.nvim' },
	},

	-- Linting and Formatting
	{
		{ 'jose-elias-alvarez/null-ls.nvim' },
		{ 'jay-babu/mason-null-ls.nvim' },
	},

	-- LSP
	{
		{ 'onsails/lspkind.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'neovim/nvim-lspconfig' },
		{ 'folke/neodev.nvim' },
		{ 'j-hui/fidget.nvim' },
		{
			'ray-x/lsp_signature.nvim',
			config = function()
				require('cabal.plugins.cfg.lspsignature')
			end,
		},
	},

	-- Completion
	{
		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lua' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'tpope/vim-sleuth' },
		{ 'L3MON4D3/LuaSnip' },
		{ 'saadparwaiz1/cmp_luasnip' },
	},

	-- Filetree
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('cabal.plugins.cfg.nvim-tree')
		end,
	},



	-- Git
	{
		{ 'petertriho/cmp-git', dependencies = 'nvim-lua/plenary.nvim' },
		{ 'tpope/vim-fugitive' },
		{ 'tpope/vim-rhubarb' },
		{
			'lewis6991/gitsigns.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('cabal.plugins.cfg.gitsigns')
			end,
		},
		{
			'sindrets/diffview.nvim',
			dependencies = 'nvim-lua/plenary.nvim',
			config = function()
				require('cabal.plugins.cfg.diffview')
			end,
		},
		{ 'akinsho/git-conflict.nvim' },
	},

	-- Search
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
	},
	{ 'nvim-telescope/telescope-ui-select.nvim' },

	-- Diagnostics
	{
		{ 'folke/trouble.nvim' },
		{ 'folke/lsp-colors.nvim' },
		{ 'nvie/vim-flake8' },
	},

	-- Debugging/Testing
	{
		{
			'nvim-neotest/neotest',
			config = function()
				require 'cabal.plugins.cfg.neotest'
			end,
			dependencies = { 'nvim-neotest/neotest-python' },
		},
		{ 'mfussenegger/nvim-dap' },
		{ 'rcarriga/nvim-dap-ui' },
		{ 'jay-babu/mason-nvim-dap.nvim' },
	},

	-- Theming
	{ 'akai54/2077.nvim' },

	-- Syntax highlighting
	{
		{
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
			},
			config = function()
				require('cabal.plugins.cfg.treesitter')
			end,
		},
	},

	-- Editing
	{
		{
			'lukas-reineke/indent-blankline.nvim',
			config = function()
				require('cabal.plugins.cfg.indentblankline')
			end,
		},
		{ 'numToStr/Comment.nvim' },
	},

	-- Utilities
	{
		{ 'simrat39/symbols-outline.nvim' },
		{ 'norcalli/nvim-colorizer.lua' },
		{ 'williamboman/mason.nvim',      build = ':MasonUpdate' },
	},

	-- Misc
	{
		'andweeb/presence.nvim',
		config = function()
			require 'cabal.plugins.cfg.presence'
		end,
	},
})
