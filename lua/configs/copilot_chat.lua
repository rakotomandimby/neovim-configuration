local file_glob_function = {
  file_glob = {
    group = "copilot",
    uri = "files://glob_contents/{pattern}",
    description = "Includes the full contents of every file matching a specified glob pattern.",
    schema = {
      type = "object",
      required = { "pattern" },
      properties = {
        pattern = {
          type = "string",
          description = "Glob pattern to match files.",
          default = "**/*",
        },
      },
    },
    resolve = function(input, source)
      local files_mod = require("copilot-chat.utils.files")
      local resources_mod = require("copilot-chat.resources")
      local files = files_mod.glob(source.cwd(), {
        pattern = input.pattern,
      })

      local resources = {}
      for _, file_path in ipairs(files) do
        local data, mimetype = resources_mod.get_file(file_path)
        if data then
          table.insert(resources, {
            uri = "file://" .. file_path,
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

local function get_system_prompt()
  local file_path = vim.fs.joinpath(vim.fn.getcwd(), ".ai-system-instructions.md")
  if vim.fn.filereadable(file_path) == 0 then
    return "You are an AI programming assistant."
  end
  local file_content = vim.fn.readfile(file_path)
  return table.concat(file_content, "\n")
end

local function config()
  require("copilot-chat").setup({
    system_prompt = get_system_prompt(),
    selection = require("copilot-chat.select").visual,
    window = {
      layout = "vertical", -- "vertical", "horizontal", "float", "replace", or function
      width = 0.4, -- fractional width of parent, or columns when > 1
      -- Floating window options
      relative = "win", -- "editor", "win", "cursor", "mouse"
      border = "solid", -- "none", "single", "double", "rounded", "solid", "shadow"
      row = nil, -- centered by default
      col = nil, -- centered by default
      title = "Copilot Chat",
      footer = nil,
      zindex = 1,
    },
    model = "mai-code-2-flash:high",
    stop_on_function_failure = true,
    functions = vim.tbl_deep_extend("force", require("copilot-chat.config.functions"), file_glob_function),
    providers = require("copilot-chat.config.providers"),
    prompts = require("copilot-chat.config.prompts"),
    mappings = require("copilot-chat.config.mappings"),
    log_level = "error",
  })
end

return config

