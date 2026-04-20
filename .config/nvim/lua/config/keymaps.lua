-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- Copy file path to clipboard
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  if path ~= "" then
    local relative_path = vim.fn.fnamemodify(path, ":.")
    vim.fn.setreg("+", relative_path)
    vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
  end
end, { desc = "Copy relative file path" })

-- Copy file path with line range in visual mode
vim.keymap.set("v", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  if path ~= "" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    local line_range = string.format("%s#L%d-%d", vim.fn.fnamemodify(path, ":."), start_line, end_line)
    vim.fn.setreg("+", line_range)
    vim.notify("Copied: " .. line_range, vim.log.levels.INFO)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end, { desc = "Copy file path with line range" })

-- lazydocker
if vim.fn.executable("lazydocker") == 1 then
  map("n", "<leader>fd", function()
    Snacks.terminal({ "lazydocker" })
  end, { desc = "LazyDocker" })
end
