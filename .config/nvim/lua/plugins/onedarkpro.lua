return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  opts = {
    colors = {},
    highlights = {},
    styles = {
      types = "NONE",
      methods = "NONE",
      numbers = "NONE",
      strings = "NONE",
      comments = "NONE",
      keywords = "NONE",
      constants = "NONE",
      functions = "NONE",
      operators = "NONE",
      variables = "NONE",
      parameters = "NONE",
      conditionals = "NONE",
      virtual_text = "NONE",
    },
    filetypes = {
      all = true,
    },
    plugins = {
      all = true,
    },
    options = {
      cursorline = false,
      transparency = false,
      terminal_colors = true,
      lualine_transparency = false,
      highlight_inactive_windows = false,
    },
  },
  config = function()
    vim.cmd.colorscheme("onedark")
  end,
}
