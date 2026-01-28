return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    -- Cleaner message format: summary, author, and relative date
    message_template = " <summary> • <author> • <date>",
    -- Relative dates are more readable (e.g., "3 days ago")
    date_format = "%r",
    -- Start virtual text at the beginning
    virtual_text_column = 1,
    -- Ignore filetypes where blame isn't useful
    ignored_filetypes = { "gitcommit", "gitrebase", "hgcommit" },
    -- Slight delay for better performance when moving cursor quickly
    delay = 500,
  },
}
