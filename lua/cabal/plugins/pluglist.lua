local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")
		-- Vim helpers
		use({ "folke/which-key.nvim", tag = "v1.2.1" })

		-- Misc
		use({
			"andweeb/presence.nvim",
			config = function()
				require("presence").setup({
					auto_update = true,
					neovim_image_text = "The One True Texteditor",
					main_image = "neovim",
					show_time = false,
					buttons = false,
				})
			end,
		})

		use({ "williamboman/mason.nvim", run = ":MasonUpdate" })

		-- Linting and Formatting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("null-ls").setup()
			end,
		})
		use({ "jay-babu/mason-null-ls.nvim", tag = "v2.0.*" })

		-- LSP
		use({
			{ "onsails/lspkind.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "folke/neodev.nvim", tag = "v2.5.*" },
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup()
				end,
			},
		})

		-- Completion
		use({
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "tpope/vim-sleuth" },
			{
				"L3MON4D3/LuaSnip",
				tag = "v1.2.*",
			},
			{ "saadparwaiz1/cmp_luasnip" },
		})

		-- Filetree
		use({ "preservim/nerdtree" })

		-- Statusline
		use({
			"nvim-lualine/lualine.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("cabal.plugins.cfg.lualine")
			end,
		})

		-- Git
		use({
			{ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
			{ "tpope/vim-fugitive" },
			{ "tpope/vim-rhubarb" },
			{
				"lewis6991/gitsigns.nvim",
				requires = { "nvim-lua/plenary.nvim" },
				config = function()
					require("cabal.plugins.cfg.gitsigns")
				end,
			},
			{
				"sindrets/diffview.nvim",
				requires = "nvim-lua/plenary.nvim",
			},
		})

		-- Search
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" } })

		-- Diagnostics
		use({
			{ "folke/trouble.nvim" },
			{ "folke/lsp-colors.nvim" },
			{ "nvie/vim-flake8" },
		})

		-- Debugging
		use({
			{ "mfussenegger/nvim-dap" },
			{ "rcarriga/nvim-dap-ui" },
			{ "jay-babu/mason-nvim-dap.nvim", tag = "v2.*" },
		})

		-- Theming
		use({ "akai54/2077.nvim" })

		-- Syntax highlighting
		use({
			{ "sheerun/vim-polyglot" },
			{
				"nvim-treesitter/nvim-treesitter",
				dependencies = {
					"nvim-treesitter/nvim-treesitter-textobjects",
				},
				config = function()
					pcall(require("nvim-treesitter.install").update({ with_sync = true }))
				end,
			},
		})

		-- Editing
		use({
			{
				"lukas-reineke/indent-blankline.nvim",
				config = function()
					require("cabal.plugins.cfg.indentblankline")
				end,
			},
			{ "numToStr/Comment.nvim" },
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = require("cabal.plugins.cfg.packer"),
})
