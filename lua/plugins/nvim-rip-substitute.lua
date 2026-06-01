return {
  -- nvim-rip-substitute: A plugin for performing search and replace operations using ripgrep
  {
    'chrisgrieser/nvim-rip-substitute',
    cmd = 'RipSubstitute',
    opts = {},
    keys = {
      {
        '<leader>sr',
        function()
          require('rip-substitute').sub()
        end,
        mode = { 'n', 'x' },
        desc = ' rip [R]eplace',
      },
    },
  },
}
