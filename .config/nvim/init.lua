-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("RunRSpec", function()
  local current_path = vim.fn.expand("%:p:h")
  vim.cmd("!cd " .. current_path .. " && rspec")
end, {})
