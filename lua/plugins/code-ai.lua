return {
  "code-ai-nvim/code-ai.nvim", 
  event = 'VeryLazy',
  lazy = false,
  keys = { },
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    -- Default/fallback model pipeline: <provider>/<model>
    models = {
      { plan      = 'anthropic/claude-haiku-4-5:low' },
      { implement = 'googleai/gemini-3.5-flash-lite:low' },
      { reword    = 'openai/gpt-6-luna:low' },
    },
    anthropic_agent_host    = 'http://192.168.122.1:6010',
    googleai_agent_host     = 'http://192.168.122.1:5010',
    openai_agent_host       = 'http://192.168.122.1:4010',
    result_popup_gets_focus = true,
    anthropic_api_key       = os.getenv('ANTHROPIC_API_KEY'),
    openai_api_key          = os.getenv('OPENAI_API_KEY'),
    googleai_api_key        = os.getenv('GOOGLEAI_API_KEY'),
    upload_url              = os.getenv('CODE_AI_UPLOAD_URL'),
    upload_token            = os.getenv('CODE_AI_UPLOAD_TOKEN'),
    stats_ingestion_token   = os.getenv('CODE_AI_INGESTION_TOKEN'),
    upload_as_public        = false,
    locale                  = 'en',
    ollama_host             = 'http://192.168.122.1:11434',
    ollama_model            = 'gemma3:4b',
    prompts = (function()
      local function createPrompt(command, models)
        return {
          command       = command,
          models        = models,
          prompt_tpl    = '${input}',
          loading_tpl   = '${input}',
          result_tpl    = '${output}',
          require_input = true,
        }
      end
      return {
        ai_code_ant_single = createPrompt(
          'AICodeAntSingle',
          {
            { plan      = 'disabled' },
            { implement = 'anthropic/claude-sonnet-5-5:medium' },
            { reword    = 'disabled' },
          }
        ),
        ai_code_ggl_single = createPrompt(
          'AICodeGglSingle',
          {
            { plan      = 'disabled' },
            { implement = 'googleai/gemini-3.8-flash:medium' },
            { reword    = 'disabled' },
          }
        ),
        ai_code_ant_medium = createPrompt(
          'AICodeAntMedium',
          {
            { plan      = 'anthropic/claude-opus-5-5:medium' },
            { implement = 'anthropic/claude-sonnet-5-5:medium' },
            { reword    = 'local' },
          }
        ),
        ai_code_ggl_medium = createPrompt(
          'AICodeGglMedium',
          {
            { plan      = 'googleai/gemini-4-argon:medium' },
            { implement = 'googleai/gemini-3.8-flash:medium' },
            { reword    = 'local' },
          }
        ),
        ai_code_ggl_high = createPrompt(
          'AICodeGglHigh',
          {
            { plan      = 'googleai/gemini-4-argon:high' },
            { implement = 'googleai/gemini-3.8-flash:high' },
            { reword    = 'local' },
          }
        ),
        ai_code_ant_high = createPrompt(
          'AICodeAntHigh',
          {
            { plan      = 'anthropic/claude-opus-5-5:high' },
            { implement = 'anthropic/claude-sonnet-5-5:high' },
            { reword    = 'local' },
          }
        ),
      }
    end)(),
  },
  config = function(_, opts)
    require("ai").setup(opts)
  end,
}
