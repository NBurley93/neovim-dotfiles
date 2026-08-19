local overseer = require('overseer')

local function makefile_cmd()
  vim.api.nvim_create_user_command('Make', function(params)
    local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
    if num_subs == 0 then
      cmd = cmd .. ' ' .. params.args
    end
    local task = overseer.new_task({
      cmd = vim.fn.expandcmd(cmd),
      components = {
        { 'open_output', on_complete = 'failure' },
        { 'on_complete_notify' },
        'default',
      },
    })
    task:start()
  end, {
    desc = 'Run make',
    nargs = '*',
    bang = true,
  })
end

local function cmake_cmds()
  vim.api.nvim_create_user_command('CMakeGen', function()
    local task = overseer.new_task({
      cmd = 'cmake',
      args = {
        'build',
      },
      components = {
        'default',
      },
      name = 'CMake Generation',
    })
    task:start()
  end, {
    desc = 'Run cmake generation',
    nargs = '*',
    bang = true,
  })
end

return {
  config = function()
    makefile_cmd()
    cmake_cmds()
  end,
}
