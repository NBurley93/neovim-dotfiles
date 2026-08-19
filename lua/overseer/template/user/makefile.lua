---@type overseer.TemplateFileDefinition
return {
  name = 'Run Makefile',
  params = {
    target = { type = 'string', default = '', desc = 'Makefile target' },
  },
  builder = function(params)
    return {
      cmd = { 'make' },
      args = { params.target },
      name = 'Makefile',
      cwd = '.',
      env = {},
    }
  end,
  desc = 'Runs makefile',
  tags = { overseer.TAG.BUILD },
}
