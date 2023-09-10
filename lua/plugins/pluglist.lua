local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set <leader> to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local WEB_DEVICONS_PROVIDER = "kyazdani42/nvim-web-devicons"
local COKELINE_WORKING_TAG = "v0.4.0"
local COKELINE_TAG = false

require("lazy").setup({
	-- Vim helpers
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{ "mg979/docgen.vim" },
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { WEB_DEVICONS_PROVIDER },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = function()
			return require("plugins.cfg.flash").options
		end,
		-- stylua: ignore
		keys = function() return require('plugins.cfg.flash').keys end,
	},

	-- Syntax highlighting
	{
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				require("plugins.cfg.treesitter")
			end,
			build = ":TSUpdate",
		},
	},

	-- Ui
	{
		{
			"stevearc/aerial.nvim",
			opts = {},
			-- Optional dependencies
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				WEB_DEVICONS_PROVIDER,
			},
		},
		{
			"willothy/nvim-cokeline",
			dependencies = {
				"nvim-lua/plenary.nvim",
				WEB_DEVICONS_PROVIDER,
			},
			config = true,
			opts = function()
				return require("plugins.cfg.cokeline")
			end,
			tag = COKELINE_TAG,
		},
		{
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require("plugins.cfg.dashboard")
			end,
			dependencies = { WEB_DEVICONS_PROVIDER },
		},
		{
			"MaximilianLloyd/ascii.nvim",
			dependencies = { "MunifTanjim/nui.nvim" },
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = WEB_DEVICONS_PROVIDER,
			config = function()
				require("plugins.cfg.lualine")
			end,
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				require("plugins.cfg.notify")
			end,
		},
		{
			"folke/noice.nvim",
			config = function()
				require("plugins.cfg.noice")
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		},
		{ "stevearc/dressing.nvim" },
	},

	-- Linting and Formatting
	{
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "jay-babu/mason-null-ls.nvim" },
	},

	-- LSP
	{
		{
			"folke/neodev.nvim",
			config = function()
				require("plugins.cfg.neodev")
			end,
		},
		{ "onsails/lspkind.nvim" },
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"folke/neodev.nvim",
			},
		},
		{ "neovim/nvim-lspconfig" },
		{ "j-hui/fidget.nvim" },
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("plugins.cfg.lspsignature")
			end,
		},
		{ "p00f/clangd_extensions.nvim" },
	},

	-- Completion
	{
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "tpope/vim-sleuth" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rcarriga/cmp-dap" },
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	-- Filetree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			WEB_DEVICONS_PROVIDER,
		},
		config = function()
			require("plugins.cfg.nvim-tree")
		end,
	},

	-- Git
	{
		{ "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
		{ "tpope/vim-fugitive" },
		{ "tpope/vim-rhubarb" },
		{
			"lewis6991/gitsigns.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("plugins.cfg.gitsigns")
			end,
		},
		{
			"sindrets/diffview.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("plugins.cfg.diffview")
			end,
		},
		{ "akinsho/git-conflict.nvim" },
	},

	-- Search
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Diagnostics
	{
		{
			"folke/trouble.nvim",
			dependencies = { WEB_DEVICONS_PROVIDER },
			opts = function()
				return require("plugins.cfg.trouble")
			end,
		},
		{ "folke/lsp-colors.nvim" },
		{ "nvie/vim-flake8" },
	},

	-- Debugging/Testing
	{
		{ "nvim-neotest/neotest-python" },
		-- {
		-- 	"alfaix/neotest-gtest",
		-- 	config = function()
		-- 		require("neotest-gtest").setup({})
		-- 	end,
		-- },
		{
			"nvim-neotest/neotest",
			config = function()
				require("plugins.cfg.neotest")
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
			},
		},
		{ "mfussenegger/nvim-dap" },
		"mfussenegger/nvim-dap-python",
		{
			"theHamsta/nvim-dap-virtual-text",
			dependencies = {
				"mfussenegger/nvim-dap",
				"nvim-treesitter/nvim-treesitter",
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("plugins.cfg.dap-ui")
			end,
		},
	},

	-- Theming
	{ "akai54/2077.nvim" },
	{ "navarasu/onedark.nvim" },
	{
		"EdenEast/nightfox.nvim",
		opts = {
			transparent = true,
		},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			commentStyle = { italic = true },
			transparent = true,
		},
	},
	{ "ray-x/aurora" },

	-- Editing
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugins.cfg.indentblankline")
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {},
		},
	},

	-- Utilities
	{
		{ "simrat39/symbols-outline.nvim" },
		{ "norcalli/nvim-colorizer.lua" },
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
			build = ":MasonUpdate",
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			config = function()
				require("plugins.cfg.mason-nvim-dap")
			end,
			dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
		},
		{
			"akinsho/toggleterm.nvim",
			opts = function()
				return require("plugins.cfg.toggleterm")
			end,
		},
	},
	{ "mechatroner/rainbow_csv" },

	-- Misc
	-- {
	-- 	"andweeb/presence.nvim",
	-- 	config = function()
	-- 		require("plugins.cfg.presence")
	-- 	end,
	-- },
})
