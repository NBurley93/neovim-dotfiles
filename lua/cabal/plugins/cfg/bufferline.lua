require('bufferline').setup({
	options = {
	  offsets = {
		{
		  filetype = "NvimTree",
		  text = "Nvim Tree",
		  separator = true,
		  text_align = "center",
		}
	  },
	  diagnostics = "nvim_lsp",
	  separator_style = {"", ""},
	  modified_icon = '●',
	  show_close_icon = true,
	  show_buffer_close_icons = true,
	}
  })
