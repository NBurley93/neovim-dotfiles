local commonfuncs = require("common.functions")

return {
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")
		local themes = require("telescope.themes")

		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		map("<leader>sf", builtin.find_files, "[F]iles")

		map("<leader>su", function()
			vim.cmd.Telescope("undo")
		end, "[U]ndo history")

		map("<C-p>", function()
			local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
			if ret == 0 then
				builtin.git_files({ show_untracked = true })
			else
				commonfuncs.nvim_notify_info("Not a git repository, defaulting to find_files instead!")
				builtin.find_files()
			end
		end, "Search git files")

		map("<leader>/", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, "[/] Fuzzily search in buffer")

		map("<leader>sc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, "[S]earch Neovim [C]onfiguration files")

		map("<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, "Grep search in files")

		map("<leader>sh", function()
			builtin.help_tags(themes.get_dropdown({
				previewer = false,
			}))
		end, "[H]elp")

		map("<leader>set", function()
			vim.cmd.Telescope("terraform_doc", "full_name=hashicorp/aws", "theme=ivy")
		end, "AWS [T]erraform Docs")

		map("<leader>seh", function()
			vim.cmd.Telescope("http", "list", "theme=ivy")
		end, "[H]ttp status codes")

		map("<leader>sgb", function()
			builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = false })
		end, "Branches")

		map("<leader>sgB", function()
			builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = true })
		end, "Branches + upstream")

		map("<leader><leader>", function()
			builtin.buffers(themes.get_dropdown({ previewer = false }), { sort_lastused = true })
		end, "Buffers")

		map("<leader>sec", function()
			vim.cmd.Telescope("cheat", "fd")
		end, "[c]heat.sh")

		map("<leader>st", builtin.treesitter, "[T]reesitter")

		map("<leader>sB", function()
			builtin.builtin(themes.get_dropdown({ previewer = false }))
		end, "Telescope [B]uiltins")

		map("<leader>sn", function()
			telescope.extensions.notify.notify(themes.get_dropdown())
		end, "[N]otifications")
	end,
}
