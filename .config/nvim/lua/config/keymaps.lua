-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- rest.nvim
map("n", "<leader>xr", "<cmd>Rest run<cr>", { desc = "Run REST request under cursor" })

-- lazydocker
if vim.fn.executable("lazydocker") == 1 then
  map("n", "<leader>gd", function()
    Snacks.terminal({ "lazydocker" })
  end, { desc = "LazyDocker" })
end
