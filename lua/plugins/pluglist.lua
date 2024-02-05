-- Set <leader> to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local WEB_DEVICONS_PROVIDER = "kyazdani42/nvim-web-devicons"

require("lazy").setup({
	{ "maxmx03/FluoroMachine.nvim" },
	-- Vim helpers
	{
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
			config = function()
				require("plugins.cfg.oil")
			end,
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
		{
			"stevearc/overseer.nvim",
			opts = {},
		},
	},

	-- Editing
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			config = function()
				require("plugins.cfg.indentblankline")
			end,
		},
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
		{
			"nvim-treesitter/nvim-treesitter-context",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				require("plugins.cfg.treesittercontext")
			end,
		},
		{
			"kevinhwang91/nvim-ufo",
			config = function()
				require("plugins.cfg.ufo")
			end,
			dependencies = {
				"kevinhwang91/promise-async",
			},
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
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require("plugins.cfg.dashboard")
			end,
			dependencies = { WEB_DEVICONS_PROVIDER },
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
		{ "tjdevries/colorbuddy.nvim" },
	},

	-- Linting and Formatting
	{
		{ "nvimtools/none-ls.nvim" },
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
		{ "p00f/clangd_extensions.nvim" },
	},

	-- Completion
	{
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
		{ "tpope/vim-sleuth" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rcarriga/cmp-dap" },
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", "molleweide/LuaSnip-snippets.nvim" },
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
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "xiyaowong/telescope-emoji.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
		{ "ANGkeith/telescope-terraform-doc.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
		{ "barrett-ruth/telescope-http.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	},

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
		{
			"nvim-neotest/neotest",
			config = function()
				require("plugins.cfg.neotest")
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-python",
			},
		},
		{ "mfussenegger/nvim-dap" },
		{ "mfussenegger/nvim-dap-python" },
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
})
