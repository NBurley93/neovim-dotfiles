local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local ensure_lazy = function()
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
end

local lazy_bootstrap = ensure_lazy()

-- Set <leader> to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('lazy').setup({
		-- Vim helpers
		{ 'folke/which-key.nvim' },

		{ 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },

		{
				'glepnir/dashboard-nvim',
				event = 'VimEnter',
				config = function()
					require('cabal.plugins.cfg.dashboard')
				end,
				dependencies = {'nvim-tree/nvim-web-devicons'}
		},
		{
			'MaximilianLloyd/ascii.nvim',
			dependencies = { 'MunifTanjim/nui.nvim' },
		},

		-- Misc
		{
			'andweeb/presence.nvim',
			config = function()
				require('presence').setup({
					auto_update = true,
					neovim_image_text = 'The One True Texteditor',
					main_image = 'neovim',
					show_time = false,
					buttons = false,
				})
			end,
		},
		{
			'rcarriga/nvim-notify',
			config = function()
				require('notify').setup({
						background_colour = '#000000',
				})
				vim.notify = require('notify')
			end,
		},
		{
			'folke/noice.nvim',
			config = function()
				require('noice').setup({
					lsp = {
						signature = {
							enabled = false,
						},
						override = {
							['vim.lsp.util.convert_input_to_markdown_lines'] = false,
							['vim.lsp.util.stylize_markdown'] = false,
							['cmp.entry.get_documentation'] = false,
						},
					},
					presets = {
						bottom_search = true,
						command_palette = true,
						long_message_to_split = true,
						inc_rename = false,
						lsp_doc_border = false,
					},
				})
			end,
			dependencies = {
				'MunifTanjim/nui.nvim',
				'rcarriga/nvim-notify',
			},
		},

		{ 'stevearc/dressing.nvim' },
		{ 'williamboman/mason.nvim', build = ':MasonUpdate' },

		-- Linting and Formatting
		{
			'jose-elias-alvarez/null-ls.nvim',
			config = function()
				require('null-ls').setup()
			end,
		},
		{ 'jay-babu/mason-null-ls.nvim' },

		-- LSP
		{
			{ 'onsails/lspkind.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'neovim/nvim-lspconfig' },
			{ 'folke/neodev.nvim' },
			{
				'j-hui/fidget.nvim',
				config = function()
					require('fidget').setup()
				end,
			},
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
			{
				'L3MON4D3/LuaSnip',
			},
			{ 'saadparwaiz1/cmp_luasnip' },
		},

		-- Filetree
			{
						'nvim-tree/nvim-tree.lua',
						dependencies = {
							'nvim-tree/nvim-web-devicons',
						},
						config = function()
							require('nvim-tree').setup {
								renderer = {
									highlight_opened_files = 'name',
									group_empty = true,
								}
							}
						end,
			},
		{ 'nvim-tree/nvim-web-devicons' },

		-- Statusline
		{
			'nvim-lualine/lualine.nvim',
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('cabal.plugins.cfg.lualine')
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
			dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', },
			config = function()
				require('telescope').setup({})
			end,
		},
		{'nvim-telescope/telescope-ui-select.nvim' },

		-- Diagnostics
		{
			{ 'folke/trouble.nvim' },
			{ 'folke/lsp-colors.nvim' },
			{ 'nvie/vim-flake8' },
		},

		-- Debugging
		{
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
					pcall(require('nvim-treesitter.install').update({ with_sync = true }))
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

		{
			'simrat39/symbols-outline.nvim',
			config = function()
				require('symbols-outline').setup()
			end,
		},

		-- Utilities
		{ 'norcalli/nvim-colorizer.lua' },
	})
