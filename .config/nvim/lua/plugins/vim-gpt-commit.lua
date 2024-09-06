return {
  "skywind3000/vim-gpt-commit",
  config = function()
    vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY") -- Your openai apikey
    -- vim.g.gpt_commit_proxy = '' -- proxy
    -- vim.g.gpt_commit_concise = 0 -- set to 1 to generate less verbose message
    -- vim.g.gpt_commit_lang = '' -- output language
    vim.g.git_commit_model = "gpt-4o" -- ChatGPT model
    -- vim.g.gpt_commit_staged = 1 -- set to 1 to use staged diff
    -- vim.g.gpt_commit_max_line = 160 -- max diff lines to reference
    -- vim.g.gpt_commit_url  = ''  -- alternative request URL, the default URL is "https://api.openai.com", can be changed setting
    -- vim.g.gpt_commit_python = '' -- specify the Python executable file explicitly
    -- vim.g.gpt_commit_engine = 'chatgpt' -- change to 'ollama' to use Ollama
    -- vim.g.gpt_commit_ollama_model = '' -- ollama model
    -- vim.g.gpt_commit_ollama_url = '' -- explicitly setting ollama URL
  end,
}
