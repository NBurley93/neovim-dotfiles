return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		map("<leader>ga", function()
			local toStage = vim.fn.expand("%:p")
			vim.cmd.Git("add " .. toStage)
			print("Staged " .. toStage)
		end, "Add currently open file to git staged")

		map("<leader>gc", function()
			vim.cmd.Git("commit")
		end, "Makes a git commit")

		map("<leader>gs", vim.cmd.Git, "Open up fugitive for git")

		map("<leader>gp", function()
			vim.cmd.Git("-c push.default=current push")
		end, "Push to git-remote")

		map("<leader>gP", function()
			vim.cmd.Git("pull")
		end, "Pull from git-remote")

		map("<leader>gd", vim.cmd.Gdiffsplit, "Open up Gdiff in vim-fugitive for the current file")

		map("<leader>gr", function()
			vim.cmd.Git("diff --staged")
		end, "Show a review diff for all our staged changes")

		map("<leader>gb", function()
			vim.cmd.Git("branch ")
		end, "Git branch")

		map("<leader>go", function()
			vim.cmd.Git("checkout ")
		end, "Git checkout")

		map("<leader>dvo", vim.cmd.DiffviewOpen, "Review diffs in diffview")

		map("<leader>dvc", vim.cmd.DiffviewClose, "Close diffview if open")

		map("<leader>dvh", vim.cmd.DiffviewFileHistory, "Opens the git file history view")
	end,
}
