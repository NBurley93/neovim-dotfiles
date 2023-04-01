local builtin = require('telescope.builtin')
local map = vim.keymap.set
local globals = vim.g
local map_defaults = { noremap = true, silent = true }

globals.mapleader = ' '

map('n', '<leader>w', '<cmd>w<cr>', map_defaults)
map('n', '<leader><home>', '<cmd>source $MYVIMRC<cr>', { noremap = true, silent = false })
map('n', '<leader>n', '<cmd>set invrelativenumber<cr>', map_defaults)

map('n', '<leader>xx', '<cmd>TroubleToggle<cr>', map_defaults)
map('n', '<leader>q', '<cmd>q<cr>', map_defaults)
map('n', '<leader>Q', '<cmd>Q<cr>', map_defaults)

map('n', '<leader>bn', '<cmd>enew<cr>', map_defaults)
map('n', '<leader>b=', '<cmd>bnext<cr>', map_defaults)
map('n', '<leader>b-', '<cmd>bprev<cr>', map_defaults)
map('n', '<leader>bc', '<cmd>bd<cr>', map_defaults)


map('n', '<leader>ff', builtin.find_files)
map('', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>/', builtin.current_buffer_fuzzy_find)

