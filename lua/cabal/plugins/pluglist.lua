local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup({
	function(use)
		use 'wbthomason/packer.nvim'
		-- Vim helpers
		use { 'folke/which-key.nvim' }

		-- Completion
		use({
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'onsails/lspkind.nvim' },
			{ 'jiangmiao/auto-pairs' },
			--		{ 'dcampos/nvim-snippy' },
			--		{ 'dcampos/cmp-snippy' },
			{
				'L3MON4D3/LuaSnip',
				tag = 'v1.2.*',
			},
			{ 'williamboman/mason.nvim',          run = ':MasonUpdate' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'neovim/nvim-lspconfig' },
		})

		-- Filetree
		use({
			{ 'preservim/nerdtree' },
			{ 'tpope/vim-vinegar' },
		})

		-- Statusline
		use {
			'nvim-lualine/lualine.nvim',
			requires = 'nvim-tree/nvim-web-devicons',
			config = function() require('cabal.plugins.cfg.lualine') end
		}

		-- Git
		use({
			{ 'tpope/vim-fugitive' },
			{ 'tpope/vim-rhubarb' },
			{
				'lewis6991/gitsigns.nvim',
				requires = { 'nvim-lua/plenary.nvim' },
				config = function()
					require(
						'cabal.plugins.cfg.gitsigns')
				end
			}
		})

		-- Search
		use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } }

		-- Diagnostics
		use({
			{ 'folke/trouble.nvim' },
			{ 'folke/lsp-colors.nvim' },
			{ 'nvie/vim-flake8' },
			{ 'mfussenegger/nvim-dap' },
			{ 'rcarriga/nvim-dap-ui' }
		})

		-- Theming
		use { 'akai54/2077.nvim' }
		use {
			'glepnir/dashboard-nvim',
			event = 'VimEnter',
			config = function() require('cabal.plugins.cfg.dashboard') end,
			dependencies = { { 'nvim-tree/nvim-web-icons' } },
		}

		-- Syntax highlighting
		use({
			{ 'sheerun/vim-polyglot' },
			{ 'nvim-treesitter/nvim-treesitter' },
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then require('packer').sync() end
	end,
	config = require('cabal.plugins.cfg.packer')
})
