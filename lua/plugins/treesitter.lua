local DISABLE_HIGHLIGHT_THRESHOLD = 30000

return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        auto_install = false,
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            return vim.api.nvim_buf_line_count(bufnr or 0) > DISABLE_HIGHLIGHT_THRESHOLD
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
