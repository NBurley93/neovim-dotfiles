local commonfuncs = require("common.functions")

return {
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")

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
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
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

		map("<leader>sh", builtin.help_tags, "[H]elp")

		map("<leader>set", function()
			vim.cmd.Telescope("terraform_doc", "full_name=hashicorp/aws")
		end, "AWS [T]erraform Docs")

		map("<leader>seh", function()
			vim.cmd.Telescope("http", "list")
		end, "[H]ttp status codes")

		map("<leader>sgb", function()
			builtin.git_branches({ show_remote_tracking_branches = false })
		end, "Branches")

		map("<leader>sgB", function()
			builtin.git_branches({ show_remote_tracking_branches = true })
		end, "Branches + upstream")

		map("<leader><leader>", function()
			builtin.buffers({ sort_lastused = true })
		end, "Buffers")

		map("<leader>sec", function()
			vim.cmd.Telescope("cheat", "fd")
		end, "[c]heat.sh")

		map("<leader>st", builtin.treesitter, "[T]reesitter")

		map("<leader>sB", builtin.builtin, "Telescope [B]uiltins")

		map("<leader>sn", function()
			telescope.extensions.notify.notify()
		end, "[N]otifications")
	end,
}
