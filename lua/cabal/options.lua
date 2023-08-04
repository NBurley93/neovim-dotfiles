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
			foldmethod = "expr",
			foldexpr = "nvim_treesitter#foldexpr()",
			foldenable = false,
			list = true,
			background = "",
		}

		for k, v in pairs(options) do
			vim.opt[k] = v
		end

		vim.lsp.set_log_level("off")

		if vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1 then
			local powershell_options = {
				shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
				shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
				shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
				shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
				shellquote = "",
				shellxquote = "",
			}

			for option, value in pairs(powershell_options) do
				vim.opt[option] = value
			end
		else
			local shell_options = {
				shell = vim.fn.executable("zsh") == 1 and "zsh",
			}

			for option, value in pairs(shell_options) do
				vim.opt[option] = value
			end
		end

		-- Configure python runtime for windows
		if vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1 then
			local pythonRoot = os.getenv("PYTHON_HOME") or ""
			vim.g.python3_host_prog = pythonRoot .. "\\python.exe"
		else
			vim.g.python3_host_prog = "~/.nvimenv/.venv/bin/python3"
		end
	end,
}
