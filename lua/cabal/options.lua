return {
	config = function()
		local options = {
			fileformat = "unix",
			autoindent = true,
			encoding = "UTF-8",
			updatetime = 250,
			timeout = true,
			timeoutlen = 300,
			expandtab = true,
			title = true,
			shiftwidth = 4,
			tabstop = 4,
			backspace = "indent,eol,start",
			smartindent = true,
			number = true,
			relativenumber = false,
			signcolumn = "yes:1",
			clipboard = "unnamedplus",
			termguicolors = true,
			cursorline = true,
			cot = "menu,menuone,noselect",
			foldmethod="expr",
			foldexpr="nvim_treesitter#foldexpr()",
			foldenable=false,
			list=true,
		}

		for k, v in pairs(options) do
			vim.opt[k] = v
		end

		-- Configure python runtime for windows
		if vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1 then
			local pythonRoot = os.getenv("PYTHON_HOME") or ""
			vim.g.python3_host_prog = pythonRoot .. "\\python.exe"
		end
	end,
}
