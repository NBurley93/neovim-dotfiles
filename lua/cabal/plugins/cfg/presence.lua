require("presence").setup({
	auto_update = true,
	neovim_image_text = "The One True Text Editor",
	main_image = "neovim",
	show_time = false,
	buttons = false,

	editing_text = "Editing %s",
	file_explorer_text = "Browsing",
	git_commit_text = "Committing changes",
	plugin_manager_text = "Managing plugins",
	reading_text = "Reading %s",
	workspace_text = "Workspace %s",
	line_number_text = "Line %s/%s",
})
