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
      require('nvim-treesitter').setup()
    end,
  },
}
