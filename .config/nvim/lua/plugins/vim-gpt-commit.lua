return {
  "skywind3000/vim-gpt-commit",
  config = function()
    vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
  end,
}
