local file_glob_function = {
  file_glob = {
    group = 'copilot',
    uri = 'files://glob_contents/{pattern}',
    description = 'Includes the full contents of every file matching a specified glob pattern.',
    schema = {
      type = 'object',
      required = { 'pattern' },
      properties = {
        pattern = {
          type = 'string',
          description = 'Glob pattern to match files.',
          default = '**/*',
        },
      },
    },
    resolve = function(input, source)
      local files = require('CopilotChat.utils.files').glob(source.cwd(), {
        pattern = input.pattern,
      })

      local resources = {}
      for _, file_path in ipairs(files) do
        local data, mimetype = require('CopilotChat.resources').get_file(file_path)
        if data then
          table.insert(resources, {
            uri = 'file://' .. file_path,
            name = file_path,
            mimetype = mimetype,
            data = data,
          })
        end
      end

      return resources
    end,
  },
}

local get_system_prompt = function()
  local file_path = vim.fn.getcwd() .. '/.ai-system-instructions.md'
  if vim.fn.filereadable(file_path) == 0 then
    return "You are an AI programming assistant."
  end
  local file_content = vim.fn.readfile(file_path)
  return table.concat(file_content, '\n')
end

local config = function()
  require("CopilotChat").setup {
    system_prompt = get_system_prompt(),
    selection = require('CopilotChat.select').visual,
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
      width = 0.4, -- fractional width of parent, or absolute width in columns when > 1
      -- Options below only apply to floating windows
      relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
      border = 'solid', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = nil, -- row position of the window, default is centered
      col = nil, -- column position of the window, default is centered
      title = 'Copilot Chat', -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1, -- determines if window is on top or below other floating windows
    },
    model = 'gpt-5.4',
    stop_on_function_failure = true,
    functions = vim.tbl_deep_extend('force', require("CopilotChat.config.functions"), file_glob_function),
    providers = require('CopilotChat.config.providers'),
    prompts = require('CopilotChat.config.prompts'),
    mappings = require('CopilotChat.config.mappings'),
    log_level = 'debug'
  }
end

return config
