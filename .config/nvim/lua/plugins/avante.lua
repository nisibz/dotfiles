return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  enabled = false,
  opts = {
    -- add any opts here
    provider = "openai",
    auto_suggestions_provider = "openai",
    openai = {
      endpoint = "https://openrouter.ai/api/v1",
      model = "openai/gpt-4o-mini",
      temperature = 0.7,
      timeout = 30000,
      max_completion_tokens = 16384,
      max_tokens = 20480,
      api_key_name = "OPENROUTER_API_KEY",
    },
    -- openai = {
    --   endpoint = "https://api.deepseek.com",
    --   model = "deepseek-chat",
    --   model = "gpt-4o-mini",
    --   temperature = 0,
    --   api_key_name = "DEEPSEEK_API_KEY",
    --   model = "o1-preview",
    -- },
    -- deepseek = {
    --   endpoint = "https://api.deepseek.com/v1",
    --   model = "deepseek-chat",
    --   temperature = 0,
    --   api_key_name = "DEEPSEEK_API_KEY",
    -- },
    -- claude = {
    --   endpoint = "https://api.anthropic.com",
    --   model = "claude-3-5-sonnet-20241022",
    --   temperature = 0,
    --   -- max_tokens = 4096,
    -- },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false, -- Experimental stage
      auto_suggestions_respect_ignore = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
