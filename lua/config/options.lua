-- Set <leader> to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return {
	config = function()
		local options = {
			autoindent = true,
			encoding = "UTF-8",
			updatetime = 50,
			timeout = true,
			timeoutlen = 1000,
			expandtab = true,
			title = true,
			shiftwidth = 4,
			fileformat = "unix",
			tabstop = 4,
			history = 50,
			backspace = "indent,eol,start",
			smartindent = true,
			number = true,
			showmode = false,
			cmdheight = 2,
			breakindent = true,
			mouse = "a",
			relativenumber = true,
			signcolumn = "yes:2",
			clipboard = "unnamedplus",
			termguicolors = true,
			cursorline = true,
			cot = "menu,menuone,noselect",
			wrap = false,
			swapfile = false,
			backup = false,
			hlsearch = true,
			incsearch = true,
			foldcolumn = "1",
			foldlevel = 99,
			foldlevelstart = 99,
			foldenable = true,
			inccommand = "split",
			scrolloff = 8,
			list = true,
			listchars = {
				tab = "» ",
				trail = "·",
				nbsp = "␣",
			},
			gdefault = true,
			background = "",
			pb = 15,
			splitright = true,
			splitbelow = true,
			fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" },
		}

		for k, v in pairs(options) do
			vim.opt[k] = v
		end
		vim.opt.isfname:append("@-@")

		-- MUCH better clipboard
		vim.g.clipboard = {
			name = "xclip-wsl",
			copy = {
				["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
				["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
			},
			paste = {
				["+"] = { "xclip", "-o", "-selection", "clipboard" },
				["*"] = { "xclip", "-o", "-selection", "primary" },
			},
			cache_enabled = 1,
		}

		vim.lsp.set_log_level("off")

		if vim.fn.has("win32") == 1 and vim.fn.has("wsl") == 0 then
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

		-- Configure python runtime for windowps
		if vim.fn.has("win32") == 1 then
			local pythonRoot = os.getenv("PYTHON_HOME") or ""
			vim.g.python3_host_prog = pythonRoot .. "\\python.exe"
		else
			vim.g.python3_host_prog = "~/.nvimenv/.venv/bin/python3"
		end

		-- Set path for sqlite3 for windows
		if vim.fn.has("win32") == 1 then
			vim.g.sqlite_clib_path = vim.fn.stdpath("data") .. "/sqlite3.dll"
		end

		-- Misc provider vars
		vim.g.loaded_perl_provider = 0
		vim.g.loaded_ruby_provider = 0
	end,
}
