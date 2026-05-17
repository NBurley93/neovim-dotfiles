local PROFILE_CONFIG_MODULES = false

local lzy_module = {
  config = function()
    require('lazy').setup('plugins', {
      ui = {
        border = 'rounded',
        icons = {
          cmd = ' ',
          config = '',
          debug = '● ',
          event = ' ',
          favorite = ' ',
          ft = ' ',
          init = ' ',
          import = ' ',
          keys = ' ',
          lazy = '󰒲 ',
          loaded = '●',
          not_loaded = '○',
          plugin = '󰀘 ',
          runtime = ' ',
          require = '󰢱 ',
          source = ' ',
          start = ' ',
          task = '✔ ',
          list = {
            '◆',
            '▶',
            '★',
            '✖',
          },
        },
      },
      checker = { enabled = false },
      change_detection = { notify = false },
      dev = {
        path = '~/neovim-projects',
        patterns = {},
        fallback = true,
      },
      performance = {
        cache = { enabled = true },
        rtp = {
          disabled_plugins = {
            'netrwPlugin',
            'tarPlugin',
            'tohtml',
            'tutor',
            'gzip',
            'zipPlugin',
            'matchit',
            'matchparen',
            'osc52',
            'shada',
            'man',
            'spec',
            'net',
            'spellfile',
            'rplugin',
          },
        },
      },
    })
  end,
}

local config_module = function(key, module)
  return {
    key = key,
    module = module,
  }
end

local config_entries = {
  config_module('options', require('config.options')),
  config_module('plugins', lzy_module),
  config_module('completion', require('config.completion')),
  config_module('lsp', require('config.lsp')),
  config_module('autocmd', require('config.autocommands')),
  config_module('keymaps', require('config.keymaps')),
  config_module('theming', require('config.theming')),
}

return {
  config_all = function()
    for _, entry in ipairs(config_entries) do
      local module = entry.module
      if module and type(module.config) == 'function' then
        if PROFILE_CONFIG_MODULES == true then
          local _profile_config_start_time = os.clock()
        end
        module.config()
        if PROFILE_CONFIG_MODULES == true then
          local _profile_config_end_time = os.clock()
          local _profile_config_elapsed_time = _profile_config_end_time - _profile_config_start_time
          print(string.format('Module %s took %.4f seconds to configure', entry.key, _profile_config_elapsed_time))
        end
      else
        vim.notify(
          'Skipping config module: ' .. entry.key .. ' - config function missing or invalid',
          vim.log.levels.WARN
        )
      end
    end
  end,
}
