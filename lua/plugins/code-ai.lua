return {
  "code-ai-nvim/code-ai.nvim",
  event = 'VeryLazy',
  lazy = false,
  keys = { },
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    anthropic_model         = 'claude-haiku-4-5',
    googleai_model          = 'gemini-3.5-flash-lite',
    openai_model            = 'gpt-5.4-nano',
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
    append_embeded_system_instructions = true,
    locale                  = 'en',
    ollama_host             = 'http://192.168.122.1:11434',
    ollama_model            = 'brnpistone/Qwen3.5-4B-AgentCoder-q6-k',
    prompts = (function()
      local function createPrompt(command, models, query_mode, append_embeded_system_instructions)
        return {
          command         = command,
          anthropic_model = models.anthropic_model,
          googleai_model  = models.googleai_model,
          openai_model    = models.openai_model,
          prompt_tpl      = '${input}',
          loading_tpl     = '${input}',
          result_tpl      = '${output}',
          require_input   = true,
          query_mode      = query_mode or 'agent',
          append_embeded_system_instructions = append_embeded_system_instructions
        }
      end
      return {
        -- Micro is only Dual
        ai_code_micro_dual= createPrompt(
          'AICodeMicroDual',
          {
            anthropic_model='disabled',
            googleai_model='gemini-3.8-flash-minimal',
            openai_model='gpt-5.4-nano',
          },
          'auto'
        ),
        -- Mini is Ant, Ggl, Dual
        ai_code_mini_ant = createPrompt(
          'AICodeMiniAnt',
          {
            anthropic_model='claude-sonnet-5-low',
            googleai_model= 'disabled',
            openai_model='disabled',
          },
          'auto'),
        ai_code_mini_ggl = createPrompt(
          'AICodeMiniGgl',
          {
            anthropic_model='disabled',
            googleai_model= 'gemini-3.8-flash-low',
            openai_model='disabled',
          },
          'auto'),
        ai_code_mini_dual = createPrompt(
          'AICodeMiniDual',
          {
            anthropic_model='claude-sonnet-5-low',
            googleai_model= 'gemini-3.8-flash-low',
            openai_model='disabled',
          },
          'auto'),
        -- Medium is Ant, Ggl, Dual
        ai_code_medium_ant = createPrompt(
          'AICodeMediumAnt',
          {
            anthropic_model='claude-sonnet-5-medium',
            googleai_model='disabled',
            openai_model='disabled',
          },
          'auto'
        ),
        ai_code_medium_ggl = createPrompt(
          'AICodeMediumGgl',
          {
            anthropic_model='disabled',
            googleai_model='gemini-3.8-flash-medium',
            openai_model='disabled',
          },
          'auto'
        ),
        ai_code_medium_dual  = createPrompt(
          'AICodeMediumDual',
          {
            anthropic_model='claude-sonnet-5-medium',
            googleai_model='gemini-3.8-flash-medium',
            openai_model='disabled',
            },
          'auto'
        ),
        -- Maxi is Ant, Ggl and Trial
        ai_code_maxi_ant = createPrompt(
          'AICodeMaxiAnt',
          {
            anthropic_model= 'claude-sonnet-5-high',
            googleai_model= 'disabled',
            openai_model= 'disabled',
          },
          'auto'
        ),
        ai_code_maxi_ggl = createPrompt(
          'AICodeMaxiGgl',
          {
            anthropic_model= 'disabled',
            googleai_model= 'gemini-3.8-flash-high',
            openai_model= 'disabled',
          },
          'auto'
        ),
        ai_code_maxi_trial = createPrompt(
          'AICodeMaxiTrial',
          {
            anthropic_model= 'claude-sonnet-5-high',
            googleai_model='gemini-3.8-flash-high',
            openai_model= 'gpt-5.6-terra',
          },
          'auto'
        ),
      }
    end)(),
  }
}
