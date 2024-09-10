local utils = require("telescope.utils")
local themes = require("telescope.themes")
local cf = require("common.functions")

local search_map = function(keys, action, desc)
	cf.mapn("<leader>s" .. keys, action, desc)
end

local M = {}

local function map_builtins()
	local builtin = require("telescope.builtin")

	-- Ctrl+p for searching project files
	cf.mapn("<C-p>", function()
		local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
		if ret == 0 then
			builtin.git_files({ show_untracked = true })
		else
			require("common.functions").nvim_notify_info("Not a git repository, defaulting to find_files instead!")
			builtin.find_files()
		end
	end, "Search git files")

	-- Files
	search_map("ff", builtin.find_files, "[F]iles")
	search_map("ft", builtin.filetypes, "[F]ile [T]ypes")

	-- Highlights & Autocommands
	search_map("l", builtin.highlights, "[H]ighlights")
	search_map("a", builtin.autocommands, "[A]utocommands")

	-- Search nvim config
	search_map("c", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, "Neovim [C]onfiguration file search")

	-- Allow searching our project with grep
	cf.mapn("<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end, "Grep search in files")

	-- Help
	search_map("h", function()
		builtin.help_tags()
	end, "[H]elp")

	-- Git
	search_map("gb", function()
		builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = false })
	end, "Branches")
	search_map("gB", function()
		builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = true })
	end, "Branches + upstream")

	-- Currently open buffers
	cf.mapn("<leader><leader>", function()
		builtin.buffers(themes.get_dropdown({ previewer = false }), { sort_lastused = true })
	end, "Buffers")

	-- Treesitter
	search_map("t", builtin.treesitter, "[T]reesitter")
end

local function map_extensions()
	local extensions = require("telescope").extensions

	-- Undo history
	search_map("u", function()
		extensions.undo.undo()
	end, "[U]ndo history")

	-- Dap
	search_map("edo", function()
		extensions.dap.configurations(themes.get_dropdown({
			previewer = true,
		}))
	end, "Dap C[O]nfigurations")

	search_map("edc", function()
		extensions.dap.commands(themes.get_dropdown({
			previewer = true,
		}))
	end, "Dap [C]ommands")

	search_map("et", function()
		extensions.terraform_doc.terraform_doc({ full_name = "hashicorp/aws" })
	end, "AWS [T]erraform Docs")

	search_map("eh", function()
		extensions.http.list({ theme = "ivy" })
	end, "[H]ttp status codes")

	search_map("ec", function()
		extensions.cheat.fd({})
	end, "[c]heat.sh")

	-- Neorg
	search_map("enw", function()
		extensions.neorg.switch_workspace()
	end, "[W]orkspaces")

	search_map("enb", function()
		extensions.neorg.find_backlinks()
	end, "[B]acklinks")

	search_map("n", function()
		extensions.notify.notify(themes.get_dropdown())
	end, "[N]otifications")

	search_map("s", function()
		extensions.aerial.aerial()
	end, "[S]ymbols")
end

function M.config()
	map_builtins()
	map_extensions()
end

function M.root_whichkey()
	return {
		{ "<leader>se", group = "[E]xtensions" },
		{ "<leader>sed", group = "[D]ap" },
		{ "<leader>sen", group = "[N]eorg" },
		{ "<leader>sf", group = "[F]iles" },
		{ "<leader>sg", group = "[G]it" },
	}
end

return M
