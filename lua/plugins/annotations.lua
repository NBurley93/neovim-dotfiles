return {
  {
    'danymat/neogen',
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
    config = true,
    opts = {
      snippet_engine = 'luasnip',
    },
    keys = {
      {
        '<leader>cn',
        function()
          require('neogen').generate()
        end,
        desc = 'Annotate class/file/function with [N]eogen',
      },
    },
  },
}
