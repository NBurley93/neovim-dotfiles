-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = true
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\nickb\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\nickb\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\nickb\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\nickb\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\nickb\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["2077.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\2077.nvim",
    url = "https://github.com/akai54/2077.nvim"
  },
  ["Comment.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31cabal.plugins.cfg.gitsigns\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&cabal.plugins.cfg.indentblankline\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30cabal.plugins.cfg.lualine\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason-null-ls.nvim",
    url = "https://github.com/jay-babu/mason-null-ls.nvim"
  },
  ["mason-nvim-dap.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason-nvim-dap.nvim",
    url = "https://github.com/jay-babu/mason-nvim-dap.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nf\0\0\5\0\5\0\t6\0\0\0006\2\1\0'\4\2\0B\2\2\0029\2\3\0025\4\4\0B\2\2\0A\0\0\1K\0\1\0\1\0\1\14with_sync\2\vupdate\28nvim-treesitter.install\frequire\npcall\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["presence.nvim"] = {
    config = { "\27LJ\2\nš\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\5\16auto_update\2\fbuttons\1\14show_time\1\15main_image\vneovim\22neovim_image_text\28The One True Texteditor\nsetup\rpresence\frequire\0" },
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\presence.nvim",
    url = "https://github.com/andweeb/presence.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-flake8"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-flake8",
    url = "https://github.com/nvie/vim-flake8"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-vinegar",
    url = "https://github.com/tpope/vim-vinegar"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "C:\\Users\\nickb\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: presence.nvim
time([[Config for presence.nvim]], true)
try_loadstring("\27LJ\2\nš\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\5\16auto_update\2\fbuttons\1\14show_time\1\15main_image\vneovim\22neovim_image_text\28The One True Texteditor\nsetup\rpresence\frequire\0", "config", "presence.nvim")
time([[Config for presence.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31cabal.plugins.cfg.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nf\0\0\5\0\5\0\t6\0\0\0006\2\1\0'\4\2\0B\2\2\0029\2\3\0025\4\4\0B\2\2\0A\0\0\1K\0\1\0\1\0\1\14with_sync\2\vupdate\28nvim-treesitter.install\frequire\npcall\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&cabal.plugins.cfg.indentblankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30cabal.plugins.cfg.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles(1) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
