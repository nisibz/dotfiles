-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ya", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy absolute directory of current file to clipboard" })

vim.keymap.set("n", "<leader>yc", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy current working directory to clipboard" })

vim.keymap.set("n", "<leader>xr", "<cmd>Rest run<cr>", { desc = "Run REST request under cursor" })
