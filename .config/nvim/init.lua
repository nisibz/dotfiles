-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("RunRSpec", function()
  local current_path = vim.fn.expand("%:p:h")
  vim.cmd("!cd " .. current_path .. " && rspec")
end, {})

vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight VertSplit guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight VertSplit guibg=NONE ctermbg=NONE]])
-- Ensure that Neo-tree windows also have transparent backgrounds
vim.cmd([[highlight NeoTreeNormal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NeoTreeFileName guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NeoTreeIndentMarker guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NeoTreeRootName guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NeoTreeGitStatus guibg=NONE ctermbg=NONE]])
