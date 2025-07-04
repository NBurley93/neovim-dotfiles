return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		map("<leader>gs", function()
			local toStage = vim.fn.expand("%:p")
			vim.cmd.Git("add " .. toStage)
			print("Staged " .. toStage)
		end, "Stage the currently open buffer")

		map("<leader>gf", vim.cmd.Git, "View git fugitive")

		map("<leader>dvo", vim.cmd.DiffviewOpen, "Review diffs in diffview")

		map("<leader>dvc", vim.cmd.DiffviewClose, "Close diffview if open")

		map("<leader>dvh", vim.cmd.DiffviewFileHistory, "Opens the git file history view")
	end,
}
